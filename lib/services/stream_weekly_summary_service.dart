import 'package:cloud_firestore/cloud_firestore.dart';

class StreamWeeklySummaryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> generateWeeklySummary(String userId, int totalViews, int newFollowers, int avgWatchTime, double totalEarnings) async {
    await _db.collection('weekly_summaries').add({
      'userId': userId,
      'totalViews': totalViews,
      'newFollowers': newFollowers,
      'avgWatchTime': avgWatchTime,
      'totalEarnings': totalEarnings,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getWeeklySummaries(String userId) {
    return _db
        .collection('weekly_summaries')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
