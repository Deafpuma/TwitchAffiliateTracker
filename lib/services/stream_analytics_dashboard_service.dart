import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAnalyticsDashboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateDashboardStats(String userId, int totalViews, int newFollowers, int avgWatchTime) async {
    await _db.collection('analytics_dashboard').doc(userId).set({
      'totalViews': totalViews,
      'newFollowers': newFollowers,
      'avgWatchTime': avgWatchTime,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  Stream<DocumentSnapshot> getDashboardStats(String userId) {
    return _db.collection('analytics_dashboard').doc(userId).snapshots();
  }
}
