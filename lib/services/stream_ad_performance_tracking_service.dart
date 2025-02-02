import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAdPerformanceTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logAdPerformance(String userId, int adViews, double adRevenue) async {
    await _db.collection('ad_performance').add({
      'userId': userId,
      'adViews': adViews,
      'adRevenue': adRevenue,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAdPerformanceStats(String userId) {
    return _db
        .collection('ad_performance')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

