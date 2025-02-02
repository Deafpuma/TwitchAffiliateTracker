class LeaderboardModel {
  final String userId;
  final String displayName;
  final int supportScore;

  LeaderboardModel({
    required this.userId,
    required this.displayName,
    required this.supportScore,
  });

  factory LeaderboardModel.fromMap(Map<String, dynamic> data) {
    return LeaderboardModel(
      userId: data['userId'] ?? '',
      displayName: data['displayName'] ?? '',
      supportScore: data['supportScore'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'supportScore': supportScore,
    };
  }
}