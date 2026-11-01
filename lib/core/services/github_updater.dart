import 'package:beu_codelab/core/utils/storage/storage_manager.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GithubUpdater {
  final String username;
  final String repoName;
  static const _githubApiBaseUrl = "https://api.github.com";
  static const _lastUpdateCheckKey = 'last_update_check';

  GithubUpdater({
    required this.username,
    required this.repoName,
    required StorageManager storageManager,
    Dio? dioClient,
  }) : _storageManager = storageManager {
    _dio = dioClient ??
        Dio(BaseOptions(
          baseUrl: _githubApiBaseUrl,
        ));
  }

  late final Dio _dio;
  final StorageManager _storageManager;

  /// Determines if we should check for updates based on the last check time
  /// Returns true if the last check was more than 24 hours ago or if there's no record of a previous check
  Future<bool> shouldCheckForUpdate() async {
    final lastCheckTime = await _storageManager.getInt(_lastUpdateCheckKey);

    if (lastCheckTime == null) {
      return true;
    }

    final lastCheck = DateTime.fromMillisecondsSinceEpoch(lastCheckTime);
    final now = DateTime.now();
    final difference = now.difference(lastCheck);

    return difference.inHours >= 24;
  }

  /// Updates the last check time to the current time
  Future<void> _updateLastCheckTime() async {
    await _storageManager.putInt(
        _lastUpdateCheckKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<GithubReleaseInfo?> checkForUpdate(String version) async {
    try {
      final response = await _dio.get(
        '/repos/$username/$repoName/releases?per_page=50',
      );

      // Update the last check time
      await _updateLastCheckTime();

      final latestRelease = _getLatestRelease(response.data, version);
      if (latestRelease == null) return null;
      String? downloadUrl;
      final Map<String, dynamic>? asset =
          (latestRelease['assets'] as List<dynamic>).firstWhereOrNull(
        (asset) => (asset['name'] as String).endsWith('apk'),
      );
      if (asset != null) {
        downloadUrl = asset['browser_download_url'];
      }

      return GithubReleaseInfo(
        version: latestRelease['name'],
        changelog: latestRelease['body'],
        publishedAt: latestRelease['published_at'] != null
            ? DateTime.tryParse(latestRelease['published_at'])
            : null,
        downloadUrl: downloadUrl,
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Map<String, dynamic>? _getLatestRelease(
      List<dynamic> releases, String currentVersion) {
    String latestVersion = currentVersion;
    Map<String, dynamic>? latestRelease;

    for (final release in releases) {
      // Remove 'v' prefix if it exists
      String releaseVersion = release['tag_name'].startsWith('v')
          ? release['tag_name'].substring(1)
          : release['tag_name'];

      bool isPreRelease = release['prerelease'];

      // Skip pre-releases
      if (isPreRelease) {
        continue;
      }

      // Compare versions and update latestRelease if a newer one is found
      if (_compareVersions(releaseVersion, latestVersion) == 1) {
        latestVersion = releaseVersion;
        latestRelease = release;
      }
    }

    return latestRelease;
  }

  int _compareVersions(String version1, String version2) {
    List<int> parseVersion(String version) {
      // Remove non-numeric and non-dot characters (e.g., 'v', extra spaces)
      version = version.replaceAll(RegExp(r'[^0-9.]'), '');

      // Split into parts and ensure each part is parsable
      return version.isNotEmpty
          ? version.split('.').map((e) => int.tryParse(e) ?? 0).toList()
          : [0];
    }

    List<int> v1 = parseVersion(version1);
    List<int> v2 = parseVersion(version2);

    for (int i = 0; i < v1.length || i < v2.length; i++) {
      int part1 =
          (i < v1.length) ? v1[i] : 0; // Default to 0 if index out of bounds
      int part2 =
          (i < v2.length) ? v2[i] : 0; // Default to 0 if index out of bounds
      if (part1 > part2) return 1;
      if (part1 < part2) return -1;
    }

    return 0; // Versions are equal
  }
}

class GithubReleaseInfo {
  final String? version;
  final String? changelog;
  final DateTime? publishedAt;
  final String? downloadUrl;
  GithubReleaseInfo({
    required this.version,
    required this.changelog,
    required this.publishedAt,
    required this.downloadUrl,
  });
}
