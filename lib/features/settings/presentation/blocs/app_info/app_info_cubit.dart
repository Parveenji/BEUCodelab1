import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_info_state.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  AppInfoCubit()
      : super(
          AppInfoInitial(),
        );

  Future<void> getAppInfo() async {
    emit(AppInfoLoading());
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(
      AppInfoLoaded(
        appVersionName: packageInfo.version,
      ),
    );
  }
}
