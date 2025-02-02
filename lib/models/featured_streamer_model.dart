class FeaturedStreamerModel {
  final String id;
  final String displayName;
  final String profileImageUrl;
  final int shoutouts;
  final bool isPremium;

  FeaturedStreamerModel({
    required this.id,
    required this.displayName,
    required this.profileImageUrl,
    required this.shoutouts,
    required this.isPremium,
  });

  factory FeaturedStreamerModel.fromMap(Map<String, dynamic> data) {
    return FeaturedStreamerModel(
      id: data['id'] ?? '',
      displayName: data['displayName'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      shoutouts: data['shoutouts'] ?? 0,
      isPremium: data['isPremium'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'profileImageUrl': profileImageUrl,
      'shoutouts': shoutouts,
      'isPremium': isPremium,
    };
  }
}
