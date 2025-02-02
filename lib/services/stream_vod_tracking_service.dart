import 'package:cloud_firestore/cloud_firestore.dart';

class StreamVODTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logVODPerformance(
      String userId, String vodUrl, int totalViews, int likes, int comments) async {
    await _db.collection('stream_vods').add({
      'userId': userId,
      'vodUrl': vodUrl,
      'totalViews': totalViews,
      'likes': likes,
      'comments': comments,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getVODPerformance(String userId) {
    return _db
        .collection('stream_vods')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
