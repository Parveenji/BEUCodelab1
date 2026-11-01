class Contest {
  String? title;
  String? titleSlug;
  DateTime? startTime;
  String? cardImg;
  int? duration;

  Contest({
    this.title,
    this.titleSlug,
    this.startTime,
    this.cardImg,
    this.duration,
  });
  // Convert Contest object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'titleSlug': titleSlug,
      'startTime': startTime?.toIso8601String(),
      'cardImg': cardImg,
      'duration': duration,
    };
  }

  // Create Contest object from JSON Map
  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      title: json['title'] as String?,
      titleSlug: json['titleSlug'] as String?,
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'] as String)
          : null,
      cardImg: json['cardImg'] as String?,
      duration: json['duration'] as int?,
    );
  }
}
