class UserProfileCalendar {
  final List<int>? activeYears;
  final int? streak;
  final int? totalActiveDays;
  final List<CalendarSubmission>? submissionCalendar;

  UserProfileCalendar({
    this.activeYears,
    this.streak,
    this.totalActiveDays,
    this.submissionCalendar,
  });

  factory UserProfileCalendar.fromJson(Map<String, dynamic> json) {
    return UserProfileCalendar(
      activeYears: (json['activeYears'] as List<dynamic>?)?.cast<int>(),
      streak: json['streak'] as int?,
      totalActiveDays: json['totalActiveDays'] as int?,
      submissionCalendar: (json['submissionCalendar'] as List<dynamic>?)
          ?.map((e) => CalendarSubmission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeYears': activeYears,
      'streak': streak,
      'totalActiveDays': totalActiveDays,
      'submissionCalendar': submissionCalendar?.map((e) => e.toJson()).toList(),
    };
  }

  UserProfileCalendar copyWith({
    List<int>? activeYears,
    int? streak,
    int? totalActiveDays,
    List<CalendarSubmission>? submissionCalendar,
  }) {
    return UserProfileCalendar(
      activeYears: activeYears ?? this.activeYears,
      streak: streak ?? this.streak,
      totalActiveDays: totalActiveDays ?? this.totalActiveDays,
      submissionCalendar: submissionCalendar ?? this.submissionCalendar,
    );
  }
}

class CalendarSubmission {
  final int timeStamp;
  final int submissionCount;

  const CalendarSubmission({
    required this.timeStamp,
    required this.submissionCount,
  });

  factory CalendarSubmission.fromJson(Map<String, dynamic> json) {
    return CalendarSubmission(
      timeStamp: json['timeStamp'] as int,
      submissionCount: json['submissionCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeStamp': timeStamp,
      'submissionCount': submissionCount,
    };
  }

  CalendarSubmission copyWith({
    int? timeStamp,
    int? submissionCount,
  }) {
    return CalendarSubmission(
      timeStamp: timeStamp ?? this.timeStamp,
      submissionCount: submissionCount ?? this.submissionCount,
    );
  }

  @override
  String toString() {
    return 'CalendarSubmission{timeStamp: $timeStamp, submissionCount: $submissionCount}';
  }
}
