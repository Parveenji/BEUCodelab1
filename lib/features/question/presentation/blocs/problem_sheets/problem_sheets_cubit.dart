import 'package:bloc/bloc.dart';
import 'package:beu_codelab/core/api/api_state.dart';
import 'package:beu_codelab/features/question/domain/model/problem_sheet.dart';
import 'package:beu_codelab/features/question/domain/repository/favorite_questions_repository.dart';

typedef ProblemSheetsState = ApiState<List<ProblemSheet>, Exception>;

class ProblemSheetsCubit extends Cubit<ProblemSheetsState> {
  ProblemSheetsCubit(this.favoriteQuestionsRepository)
      : super(ApiState.initial());
  final FavoriteQuestionsRepository favoriteQuestionsRepository;

  Future<void> fetchProblemSheets() async {
    emit(const ApiLoading());
    final result = await favoriteQuestionsRepository.getProblemSheets();
    result.when(
      onSuccess: (lists) {
        emit(ApiLoaded(lists));
      },
      onFailure: (exception) {
        emit(ApiError(exception));
      },
    );
  }
}
