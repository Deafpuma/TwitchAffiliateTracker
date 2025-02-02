import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAnalyticsInsightsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logAnalyticsInsight(
      String userId, int peakViewers, int avgWatchTime, String mostPopularContent) async {
    await _db.collection('analytics_insights').add({
      'userId': userId,
      'peakViewers': peakViewers,
      'avgWatchTime': avgWatchTime,
      'mostPopularContent': mostPopularContent, // Example: "Just Chatting", "FPS Games"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAnalyticsInsights(String userId) {
    return _db
        .collection('analytics_insights')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
