class UserStatusEntity {
  final String username;
  final String realName;
  final String avatar;

  UserStatusEntity({
    required this.username,
    required this.realName,
    required this.avatar,
  });

  factory UserStatusEntity.fromJson(Map<String, dynamic> json) {
    return UserStatusEntity(
      username: json['username'] ?? '',
      realName: json['realName'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'realName': realName,
      'avatar': avatar,
    };
  }
}
