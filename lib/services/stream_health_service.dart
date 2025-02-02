import 'package:cloud_firestore/cloud_firestore.dart';

class StreamHealthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logStreamHealth(
      String userId, double bitrate, int droppedFrames, String status) async {
    await _db.collection('stream_health_logs').add({
      'userId': userId,
      'bitrate': bitrate,
      'droppedFrames': droppedFrames,
      'status': status,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getStreamHealthLogs(String userId) {
    return _db
        .collection('stream_health_logs')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
