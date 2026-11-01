import 'package:beu_codelab/features/question/data/entity/question_entity.dart';

class ProblemsetQuestionsEntity {
  ProblemsetQuestionList? problemsetQuestionList;

  ProblemsetQuestionsEntity({this.problemsetQuestionList});

  ProblemsetQuestionsEntity.fromJson(Map<String, dynamic> json) {
    problemsetQuestionList = json['problemsetQuestionList'] != null
        ? ProblemsetQuestionList.fromJson(json['problemsetQuestionList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (problemsetQuestionList != null) {
      data['problemsetQuestionList'] = problemsetQuestionList!.toJson();
    }
    return data;
  }
}

class ProblemsetQuestionList {
  int? total;
  List<QuestionNodeEntity>? questions;

  ProblemsetQuestionList({this.total, this.questions});

  ProblemsetQuestionList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['questions'] != null) {
      questions = <QuestionNodeEntity>[];
      json['questions'].forEach((v) {
        questions!.add(QuestionNodeEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
