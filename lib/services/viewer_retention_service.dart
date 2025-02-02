import 'package:cloud_firestore/cloud_firestore.dart';

class ViewerRetentionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logViewerRetention(String userId, int averageWatchTime, int returningViewers) async {
    await _db.collection('viewer_retention_logs').add({
      'userId': userId,
      'averageWatchTime': averageWatchTime,
      'returningViewers': returningViewers,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getViewerRetentionLogs(String userId) {
    return _db
        .collection('viewer_retention_logs')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
