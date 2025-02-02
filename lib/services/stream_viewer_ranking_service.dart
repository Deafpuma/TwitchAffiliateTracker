import 'package:cloud_firestore/cloud_firestore.dart';

class StreamViewerRankingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateViewerRank(String userId, String viewerId, int points) async {
    await _db.collection('viewer_ranking').doc(viewerId).set({
      'userId': userId,
      'viewerId': viewerId,
      'points': points, // Example: Engagement points from chat, watch time, etc.
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getViewerRanking(String userId) {
    return _db
        .collection('viewer_ranking')
        .where('userId', isEqualTo: userId)
        .orderBy('points', descending: true)
        .snapshots();
  }
}

