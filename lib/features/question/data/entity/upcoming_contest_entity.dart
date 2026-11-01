import 'package:beu_codelab/features/question/data/entity/contest_entity.dart';

class UpcomingContestEntity {
  List<ContestEntity>? topTwoContests;

  UpcomingContestEntity({this.topTwoContests});

  UpcomingContestEntity.fromJson(Map<String, dynamic> json) {
    if (json['topTwoContests'] != null) {
      topTwoContests = <ContestEntity>[];
      json['topTwoContests'].forEach((v) {
        topTwoContests!.add(new ContestEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topTwoContests != null) {
      data['topTwoContests'] =
          this.topTwoContests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
