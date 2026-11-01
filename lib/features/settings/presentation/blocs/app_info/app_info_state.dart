part of 'app_info_cubit.dart';

sealed class AppInfoState extends Equatable {
  const AppInfoState();

  @override
  List<Object> get props => [];
}

final class AppInfoInitial extends AppInfoState {}

final class AppInfoLoading extends AppInfoState {}

final class AppInfoLoaded extends AppInfoState {
  final String appVersionName;

  const AppInfoLoaded({
    required this.appVersionName,
  });
}
