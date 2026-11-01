import 'package:bloc/bloc.dart';
import 'package:beu_codelab/core/api/api_state.dart';
import 'package:beu_codelab/features/profile/domain/model/user_profile_calendar.dart';
import 'package:beu_codelab/features/profile/domain/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class UserProfileCalendarCubit
    extends HydratedCubit<ApiState<UserProfileCalendar, Exception>> {
  UserProfileCalendarCubit(this._profileRepository) : super(ApiState.initial());
  final ProfileRepository _profileRepository;

  Future<void> getUserProfileSubmissionCalendar(String userName) async {
    final result = await _profileRepository.getUserProfileCalendar(userName);
    result.when(
      onSuccess: (profileCalendar) {
        emit(
          ApiLoaded(
            profileCalendar,
          ),
        );
      },
      onFailure: (exception) => emit(
        ApiError(exception),
      ),
    );
  }

  @override
  ApiState<UserProfileCalendar, Exception>? fromJson(
      Map<String, dynamic> json) {
    if (json.isEmpty) {
      return ApiState.initial();
    }
    return ApiLoaded(UserProfileCalendar.fromJson(json));
  }

  @override
  Map<String, dynamic>? toJson(ApiState<UserProfileCalendar, Exception> state) {
    return state.mayBeWhen(
      orElse: () => null,
      onLoaded: (value) => value.toJson(),
    );
  }
}
