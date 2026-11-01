part of 'app_file_downloader_bloc.dart';

sealed class AppFileDownloaderEvent extends Equatable {
  const AppFileDownloaderEvent();

  @override
  List<Object> get props => [];
}

class AppFileDownloadRequest extends AppFileDownloaderEvent {
  final String downloadUrl;

  const AppFileDownloadRequest({
    required this.downloadUrl,
  });
  @override
  List<Object> get props => [downloadUrl];
}

class AppFileDownloadStatusUpdate extends AppFileDownloaderEvent {
  final num progress;
  final AppFileDownloadStatus status;
  final String downloadId;

  const AppFileDownloadStatusUpdate({
    required this.progress,
    required this.status,
    required this.downloadId,
  });
  @override
  List<Object> get props => [progress, status, downloadId];
}

enum AppFileDownloadStatus {
  /// Status of the task is either unknown or corrupted.
  undefined,

  /// The task is scheduled, but is not running yet.
  enqueued,

  /// The task is in progress.
  running,

  /// The task has completed successfully.
  complete,

  /// The task has failed.
  failed,

  /// The task was canceled and cannot be resumed.
  canceled,

  /// The task was paused and can be resumed
  paused;
}
