import 'package:cloud_firestore/cloud_firestore.dart';

class StreamMonthlyPerformanceReportService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> generateMonthlyReport(
      String userId, int totalWatchHours, int newFollowers, double totalEarnings, int peakViewers) async {
    await _db.collection('monthly_performance_reports').add({
      'userId': userId,
      'totalWatchHours': totalWatchHours,
      'newFollowers': newFollowers,
      'totalEarnings': totalEarnings,
      'peakViewers': peakViewers,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMonthlyReports(String userId) {
    return _db
        .collection('monthly_performance_reports')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

