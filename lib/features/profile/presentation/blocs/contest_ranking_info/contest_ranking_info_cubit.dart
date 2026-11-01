import 'package:bloc/bloc.dart';
import 'package:beu_codelab/core/api/api_state.dart';
import 'package:beu_codelab/features/profile/domain/model/contest_ranking_info.dart';
import 'package:beu_codelab/features/profile/domain/repository/profile_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ContestRankingInfoCubit
    extends HydratedCubit<ApiState<ContestRankingInfo, Exception>> {
  ContestRankingInfoCubit(this._profileRepository) : super(ApiState.initial());
  final ProfileRepository _profileRepository;

  Future<void> getContestRankingInfo(String userName) async {
    final rankingInfoResult =
        await _profileRepository.getContestRankingInfo(userName);
    rankingInfoResult.when(
      onSuccess: (contestRankingInfo) {
        emit(
          ApiLoaded(
            contestRankingInfo,
          ),
        );
      },
      onFailure: (exception) => emit(
        ApiError(exception),
      ),
    );
  }

  @override
  ApiState<ContestRankingInfo, Exception>? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return ApiState.initial();
    }
    return ApiLoaded(ContestRankingInfo.fromJson(json));
  }

  @override
  Map<String, dynamic>? toJson(ApiState<ContestRankingInfo, Exception> state) {
    return state.mayBeWhen(
      orElse: () => null,
      onLoaded: (rankingInfo) => rankingInfo.toJson(),
    );
  }
}
