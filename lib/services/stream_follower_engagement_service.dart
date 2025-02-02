import 'package:cloud_firestore/cloud_firestore.dart';

class StreamFollowerEngagementService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logFollowerEngagement(String userId, String viewerId, int messagesSent, int reactions) async {
    await _db.collection('follower_engagement').add({
      'userId': userId,
      'viewerId': viewerId,
      'messagesSent': messagesSent,
      'reactions': reactions,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getFollowerEngagementStats(String userId) {
    return _db
        .collection('follower_engagement')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
