class User {
  String id;
  String walletAddress;
  DateTime joinedAt;

  User({
    required this.id,
    required this.walletAddress,
    required this.joinedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      walletAddress: json['walletAddress'],
      joinedAt: DateTime.parse(json['joinedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'walletAddress': walletAddress,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}
