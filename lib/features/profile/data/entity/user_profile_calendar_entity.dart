import 'dart:convert';

import 'package:beu_codelab/features/profile/domain/model/user_profile_calendar.dart';

class UserProfileCalendarEntity {
  MatchedUser? matchedUser;

  UserProfileCalendarEntity({this.matchedUser});

  UserProfileCalendarEntity.fromJson(Map<String, dynamic> json) {
    matchedUser = json['matchedUser'] != null
        ? MatchedUser.fromJson(json['matchedUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (matchedUser != null) {
      data['matchedUser'] = matchedUser!.toJson();
    }
    return data;
  }
}

class MatchedUser {
  UserCalendar? userCalendar;

  MatchedUser({this.userCalendar});

  MatchedUser.fromJson(Map<String, dynamic> json) {
    userCalendar = json['userCalendar'] != null
        ? UserCalendar.fromJson(json['userCalendar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userCalendar != null) {
      data['userCalendar'] = userCalendar!.toJson();
    }
    return data;
  }
}

class UserCalendar {
  List<int>? activeYears;
  int? streak;
  int? totalActiveDays;
  List<DccBadges>? dccBadges;
  String? submissionCalendar;

  UserCalendar(
      {this.activeYears,
      this.streak,
      this.totalActiveDays,
      this.dccBadges,
      this.submissionCalendar});

  UserCalendar.fromJson(Map<String, dynamic> json) {
    activeYears = json['activeYears'].cast<int>();
    streak = json['streak'];
    totalActiveDays = json['totalActiveDays'];
    if (json['dccBadges'] != null) {
      dccBadges = <DccBadges>[];
      json['dccBadges'].forEach((v) {
        dccBadges!.add(DccBadges.fromJson(v));
      });
    }
    submissionCalendar = json['submissionCalendar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activeYears'] = activeYears;
    data['streak'] = streak;
    data['totalActiveDays'] = totalActiveDays;
    if (dccBadges != null) {
      data['dccBadges'] = dccBadges!.map((v) => v.toJson()).toList();
    }
    data['submissionCalendar'] = submissionCalendar;
    return data;
  }
}

class DccBadges {
  int? timestamp;
  CalendarBadge? badge;

  DccBadges({this.timestamp, this.badge});

  DccBadges.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    badge =
        json['badge'] != null ? CalendarBadge.fromJson(json['badge']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    if (badge != null) {
      data['badge'] = badge!.toJson();
    }
    return data;
  }
}

class CalendarBadge {
  String? name;
  String? icon;

  CalendarBadge({this.name, this.icon});

  CalendarBadge.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}

extension UserProfileCalendarEntityExt on UserProfileCalendarEntity {
  UserProfileCalendar toUserProfileCalendar() {
    Map<String, dynamic> submissionData =
        jsonDecode(matchedUser?.userCalendar?.submissionCalendar ?? "{}");
    return UserProfileCalendar(
      activeYears: matchedUser?.userCalendar?.activeYears,
      streak: matchedUser?.userCalendar?.streak,
      totalActiveDays: matchedUser?.userCalendar?.totalActiveDays,
      submissionCalendar: submissionData.entries.map(
        (e) {
          int time = int.parse(e.key); // Convert timestamp to integer
          int submissions = e.value;
          return CalendarSubmission(
            timeStamp: time,
            submissionCount: submissions,
          );
        },
      ).toList(),
    );
  }
}
