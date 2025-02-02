import 'package:cloud_firestore/cloud_firestore.dart';

class StreamRaidsTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logRaid(String userId, String raiderName, int viewerCount, bool isIncoming) async {
    await _db.collection('stream_raids').add({
      'userId': userId,
      'raiderName': raiderName,
      'viewerCount': viewerCount,
      'isIncoming': isIncoming,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getRaidLogs(String userId) {
    return _db
        .collection('stream_raids')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
