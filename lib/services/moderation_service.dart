import 'package:cloud_firestore/cloud_firestore.dart';

class ModerationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> reportContent(String userId, String reportedContentId, String reason) async {
    await _db.collection('reports').add({
      'userId': userId,
      'reportedContentId': reportedContentId,
      'reason': reason,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getReports() {
    return _db.collection('reports').orderBy('timestamp', descending: true).snapshots();
  }
}
