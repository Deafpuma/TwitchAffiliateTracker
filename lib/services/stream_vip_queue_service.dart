import 'package:cloud_firestore/cloud_firestore.dart';

class StreamVIPQueueService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addToVIPQueue(String userId, String viewerId, String requestType) async {
    await _db.collection('vip_queue').add({
      'userId': userId,
      'viewerId': viewerId,
      'requestType': requestType, // Example: "Play with Streamer", "Priority Q&A"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getVIPQueue(String userId) {
    return _db
        .collection('vip_queue')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
