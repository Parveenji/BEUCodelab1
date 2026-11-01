import 'package:beu_codelab/features/question/data/entity/contest_entity.dart';
import 'package:beu_codelab/features/profile/domain/model/contest_ranking_info.dart';
import 'package:beu_codelab/features/question/domain/model/contest.dart';

class ContestRankingInfoEntity {
  UserContestRankingEntity? userContestRanking;
  List<UserContestRankingHistoryEntity>? userContestRankingHistory;

  ContestRankingInfoEntity(
      {this.userContestRanking, this.userContestRankingHistory});

  ContestRankingInfoEntity.fromJson(Map<String, dynamic> json) {
    userContestRanking = json['userContestRanking'] != null
        ? UserContestRankingEntity.fromJson(json['userContestRanking'])
        : null;
    if (json['userContestRankingHistory'] != null) {
      userContestRankingHistory = <UserContestRankingHistoryEntity>[];
      json['userContestRankingHistory'].forEach((v) {
        userContestRankingHistory!
            .add(UserContestRankingHistoryEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (userContestRanking != null) {
      data['userContestRanking'] = userContestRanking!.toJson();
    }
    if (userContestRankingHistory != null) {
      data['userContestRankingHistory'] =
          userContestRankingHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserContestRankingEntity {
  int? attendedContestsCount;
  double? rating;
  int? globalRanking;
  int? totalParticipants;
  double? topPercentage;
  BadgeEntity? badge;

  UserContestRankingEntity({
    this.attendedContestsCount,
    this.rating,
    this.globalRanking,
    this.totalParticipants,
    this.topPercentage,
    this.badge,
  });

  UserContestRankingEntity.fromJson(Map<String, dynamic> json) {
    attendedContestsCount = json['attendedContestsCount'];
    rating = json['rating'];
    globalRanking = json['globalRanking'];
    totalParticipants = json['totalParticipants'];
    topPercentage = json['topPercentage'];
    badge = json['badge'] != null ? BadgeEntity.fromJson(json['badge']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['attendedContestsCount'] = attendedContestsCount;
    data['rating'] = rating;
    data['globalRanking'] = globalRanking;
    data['totalParticipants'] = totalParticipants;
    data['topPercentage'] = topPercentage;
    if (badge != null) {
      data['badge'] = badge!.toJson();
    }
    return data;
  }
}

class BadgeEntity {
  String? name;

  BadgeEntity({this.name});

  BadgeEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}

class UserContestRankingHistoryEntity {
  bool? attended;
  String? trendDirection;
  int? problemsSolved;
  int? totalProblems;
  num? rating;
  int? ranking;
  ContestEntity? contest;

  UserContestRankingHistoryEntity(
      {this.attended,
      this.trendDirection,
      this.problemsSolved,
      this.totalProblems,
      this.rating,
      this.ranking,
      this.contest});

  UserContestRankingHistoryEntity.fromJson(Map<String, dynamic> json) {
    attended = json['attended'];
    trendDirection = json['trendDirection'];
    problemsSolved = json['problemsSolved'];
    totalProblems = json['totalProblems'];
    rating = json['rating'];
    ranking = json['ranking'];
    contest = json['contest'] != null
        ? ContestEntity.fromJson(json['contest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['attended'] = attended;
    data['trendDirection'] = trendDirection;
    data['problemsSolved'] = problemsSolved;
    data['totalProblems'] = totalProblems;
    data['rating'] = rating;
    data['ranking'] = ranking;
    if (contest != null) {
      data['contest'] = contest!.toJson();
    }
    return data;
  }
}

extension ContestRankingInfoEntityExt on ContestRankingInfoEntity {
  ContestRankingInfo toContestRankingInfo() {
    return ContestRankingInfo(
      attendedContestsCount: userContestRanking?.attendedContestsCount,
      rating: userContestRanking?.rating,
      globalRanking: userContestRanking?.globalRanking,
      totalParticipants: userContestRanking?.totalParticipants,
      topPercentage: userContestRanking?.topPercentage,
      userContestRankingHistory: userContestRankingHistory
          ?.map((e) => e.toUserContestRankingHistory())
          .toList(),
    );
  }
}

extension UserContestRankingHistoryEntityExt
    on UserContestRankingHistoryEntity {
  UserContestRankingHistory toUserContestRankingHistory() {
    return UserContestRankingHistory(
        attended: attended,
        trendDirection: trendDirection,
        problemsSolved: problemsSolved,
        totalProblems: totalProblems,
        rating: rating,
        ranking: ranking,
        contest: Contest(
          title: contest?.title,
          startTime: contest?.startTime != null
              ? DateTime.fromMillisecondsSinceEpoch(1000 * contest!.startTime!)
              : null,
        ));
  }
}
