import 'package:cloud_firestore/cloud_firestore.dart';

class StreamDynamicBadgesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> assignBadge(String userId, String viewerId, String badgeType) async {
    await _db.collection('dynamic_badges').add({
      'userId': userId,
      'viewerId': viewerId,
      'badgeType': badgeType, // Example: "Chat King", "Top Donator", "Community MVP"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getBadges(String userId) {
    return _db
        .collection('dynamic_badges')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
