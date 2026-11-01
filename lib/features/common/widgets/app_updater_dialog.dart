import 'package:beu_codelab/features/common/bloc/app_file_downloader/app_file_downloader_bloc.dart';
import 'package:beu_codelab/core/services/github_updater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppUpdaterDialog extends StatelessWidget {
  const AppUpdaterDialog({
    super.key,
    required this.releaseInfo,
  });
  final GithubReleaseInfo releaseInfo;

  static void show(
    BuildContext context, {
    required GithubReleaseInfo releaseInfo,
  }) {
    final fileDownloaderBloc = context.read<AppFileDownloaderBloc>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: fileDownloaderBloc,
        child: AppUpdaterDialog(
          releaseInfo: releaseInfo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Row(
        children: [
          Icon(
            Icons.system_update,
          ),
          SizedBox(width: 10),
          Text('Update Available', style: TextStyle(fontSize: 20)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version: ${releaseInfo.version ?? "Unknown"}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Published on: ${releaseInfo.publishedAt != null ? releaseInfo.publishedAt!.toLocal().toString().split(' ')[0] : "Unknown"}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Changelog:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              releaseInfo.changelog ?? "No details provided.",
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Later'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Launch download URL
            if (releaseInfo.downloadUrl != null) {
              // Implement download logic here, such as launching a URL
              final downloaderBloc = context.read<AppFileDownloaderBloc>();
              Navigator.pop(context);
              downloaderBloc.add(
                AppFileDownloadRequest(downloadUrl: releaseInfo.downloadUrl!),
              );
            }
          },
          icon: const Icon(Icons.download),
          label: const Text('Download'),
        ),
      ],
    );
  }
}
