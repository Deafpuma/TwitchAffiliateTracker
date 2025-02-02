import 'package:cloud_firestore/cloud_firestore.dart';

class StreamTrendsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logStreamTrend(String userId, String trendType, int peakViewers, String notes) async {
    await _db.collection('stream_trends').add({
      'userId': userId,
      'trendType': trendType,
      'peakViewers': peakViewers,
      'notes': notes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getStreamTrends(String userId) {
    return _db
        .collection('stream_trends')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
