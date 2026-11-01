import 'package:beu_codelab/features/question/domain/model/contest.dart';

class ContestRankingInfo {
  final int? attendedContestsCount;
  final double? rating;
  final int? globalRanking;
  final int? totalParticipants;
  final double? topPercentage;
  final List<UserContestRankingHistory>? userContestRankingHistory;

  ContestRankingInfo({
    this.attendedContestsCount,
    this.rating,
    this.globalRanking,
    this.totalParticipants,
    this.topPercentage,
    this.userContestRankingHistory,
  });
  factory ContestRankingInfo.fromJson(Map<String, dynamic> json) {
    return ContestRankingInfo(
      attendedContestsCount: json['attendedContestsCount'] as int?,
      rating: json['rating']?.toDouble(),
      globalRanking: json['globalRanking'] as int?,
      totalParticipants: json['totalParticipants'] as int?,
      topPercentage: json['topPercentage']?.toDouble(),
      userContestRankingHistory:
          (json['userContestRankingHistory'] as List<dynamic>?)
              ?.map((e) =>
                  UserContestRankingHistory.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendedContestsCount': attendedContestsCount,
      'rating': rating,
      'globalRanking': globalRanking,
      'totalParticipants': totalParticipants,
      'topPercentage': topPercentage,
      'userContestRankingHistory':
          userContestRankingHistory?.map((e) => e.toJson()).toList(),
    };
  }
}

class UserContestRankingHistory {
  final bool? attended;
  final String? trendDirection;
  final int? problemsSolved;
  final int? totalProblems;
  final num? rating;
  final int? ranking;
  final Contest? contest;

  UserContestRankingHistory({
    this.attended,
    this.trendDirection,
    this.problemsSolved,
    this.totalProblems,
    this.rating,
    this.ranking,
    this.contest,
  });

  factory UserContestRankingHistory.fromJson(Map<String, dynamic> json) {
    return UserContestRankingHistory(
      attended: json['attended'] as bool?,
      trendDirection: json['trendDirection'] as String?,
      problemsSolved: json['problemsSolved'] as int?,
      totalProblems: json['totalProblems'] as int?,
      rating: json['rating'] as num?,
      ranking: json['ranking'] as int?,
      contest: json['contest'] != null
          ? Contest.fromJson(json['contest'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attended': attended,
      'trendDirection': trendDirection,
      'problemsSolved': problemsSolved,
      'totalProblems': totalProblems,
      'rating': rating,
      'ranking': ranking,
      'contest': contest?.toJson(),
    };
  }
}
