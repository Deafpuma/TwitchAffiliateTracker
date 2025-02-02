import 'package:cloud_firestore/cloud_firestore.dart';

class StreamPerformanceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logPerformance(String userId, int viewerCount, int durationMinutes, String game) async {
    await _db.collection('stream_performance').add({
      'userId': userId,
      'viewerCount': viewerCount,
      'durationMinutes': durationMinutes,
      'game': game,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserPerformance(String userId) {
    return _db.collection('stream_performance')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
