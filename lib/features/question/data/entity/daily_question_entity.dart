import 'package:beu_codelab/features/question/data/entity/question_entity.dart';
import 'package:beu_codelab/features/question/domain/model/question.dart';

class DailyQuestionEntity {
  ActiveDailyCodingChallengeQuestionNode? activeDailyCodingChallengeQuestion;

  DailyQuestionEntity({this.activeDailyCodingChallengeQuestion});

  DailyQuestionEntity.fromJson(Map<String, dynamic> json) {
    activeDailyCodingChallengeQuestion =
        json['activeDailyCodingChallengeQuestion'] != null
            ? ActiveDailyCodingChallengeQuestionNode.fromJson(
                json['activeDailyCodingChallengeQuestion'])
            : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'activeDailyCodingChallengeQuestion':
          activeDailyCodingChallengeQuestion?.toJson(),
    };
  }
}

class ActiveDailyCodingChallengeQuestionNode {
  String? date;
  String? link;
  QuestionNodeEntity? question;

  ActiveDailyCodingChallengeQuestionNode({this.date, this.link, this.question});

  ActiveDailyCodingChallengeQuestionNode.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    link = json['link'];
    question = json['question'] != null
        ? QuestionNodeEntity.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'link': link,
      'question': question?.toJson(),
    };
  }
}

extension DailyQuestionEntityExt on DailyQuestionEntity {
  Question toQuestion() {
    return activeDailyCodingChallengeQuestion?.question?.toQuestion() ??
        const Question();
  }
}
