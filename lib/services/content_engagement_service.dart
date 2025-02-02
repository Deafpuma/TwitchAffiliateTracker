import 'package:cloud_firestore/cloud_firestore.dart';

class ContentEngagementService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logEngagement(String userId, String contentId, int likes, int shares, int comments) async {
    await _db.collection('content_engagement').add({
      'userId': userId,
      'contentId': contentId,
      'likes': likes,
      'shares': shares,
      'comments': comments,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserEngagement(String userId) {
    return _db.collection('content_engagement')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
