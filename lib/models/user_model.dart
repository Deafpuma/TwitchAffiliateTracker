class UserModel {
  final String id;
  final String displayName;
  final String email;
  final String profileImageUrl;
  final bool isSubscriber;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.profileImageUrl,
    required this.isSubscriber,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? '',
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      isSubscriber: data['isSubscriber'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'isSubscriber': isSubscriber,
    };
  }
}
