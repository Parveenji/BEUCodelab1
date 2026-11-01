part of 'app_file_downloader_bloc.dart';

sealed class AppFileDownloaderState extends Equatable {
  const AppFileDownloaderState();

  @override
  List<Object> get props => [];
}

final class AppFileDownloaderInitial extends AppFileDownloaderState {}

final class AppFileIntiatingDownload extends AppFileDownloaderState {}

final class AppFileOngoingDownload extends AppFileDownloaderState {
  final String downloadId;
  final num progress;

  const AppFileOngoingDownload({
    required this.downloadId,
    required this.progress,
  });

  @override
  List<Object> get props => [downloadId, progress];
}

final class AppFileDownloadPaused extends AppFileDownloaderState {
  final String downloadId;
  final num progress;

  const AppFileDownloadPaused({
    required this.downloadId,
    required this.progress,
  });

  @override
  List<Object> get props => [downloadId, progress];
}

final class AppFileDownloadCompleted extends AppFileDownloaderState {
  final String downloadId;

  const AppFileDownloadCompleted({
    required this.downloadId,
  });

  @override
  List<Object> get props => [downloadId];
}

final class AppFileDownloadFailed extends AppFileDownloaderState {}

final class AppFileDownloadCancelled extends AppFileDownloaderState {}
