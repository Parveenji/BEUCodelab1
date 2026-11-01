import 'package:beu_codelab/core/utils/app_constants.dart';
import 'package:beu_codelab/features/question/domain/model/contest.dart';

class ContestEntity {
  String? title;
  String? titleSlug;
  String? cardImg;
  int? startTime;
  int? duration;

  ContestEntity({
    this.title,
    this.titleSlug,
    this.cardImg,
    this.startTime,
    this.duration,
  });

  ContestEntity.fromJson(Map<String, dynamic> json) {
    var cardImage = json['cardImg'];
    title = json['title'];
    titleSlug = json['titleSlug'];
    startTime = json['startTime'];
    duration = json['duration'];

    // set default images for contest cover image
    if (cardImage == null) {
      if (titleSlug?.startsWith('weekly') ?? false) {
        cardImage = LeetcodeConstants.weeklyContestBannerImage;
      } else {
        cardImage = LeetcodeConstants.biweeklyContestBannerImage;
      }
    }

    cardImg = cardImage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['titleSlug'] = titleSlug;
    data['cardImg'] = cardImg;
    data['startTime'] = startTime;
    data['duration'] = duration;
    return data;
  }
}

extension ContestEntityExt on ContestEntity {
  Contest toContest() {
    return Contest(
      title: title,
      titleSlug: titleSlug,
      cardImg: cardImg,
      startTime: startTime != null
          ? DateTime.fromMillisecondsSinceEpoch(startTime! * 1000)
          : null,
      duration: duration,
    );
  }
}
