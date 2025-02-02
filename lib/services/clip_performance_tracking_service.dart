import 'package:cloud_firestore/cloud_firestore.dart';

class ClipPerformanceTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logClipPerformance(String userId, String clipUrl, int views, int shares, int likes) async {
    await _db.collection('clip_performance').add({
      'userId': userId,
      'clipUrl': clipUrl,
      'views': views,
      'shares': shares,
      'likes': likes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getClipPerformanceLogs(String userId) {
    return _db
        .collection('clip_performance')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
