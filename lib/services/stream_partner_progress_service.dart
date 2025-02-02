import 'package:cloud_firestore/cloud_firestore.dart';

class StreamPartnerProgressService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logPartnerProgress(String userId, int avgViewers, int totalStreamHours, int uniqueDaysStreamed) async {
    await _db.collection('partner_progress').add({
      'userId': userId,
      'avgViewers': avgViewers,
      'totalStreamHours': totalStreamHours,
      'uniqueDaysStreamed': uniqueDaysStreamed,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getPartnerProgress(String userId) {
    return _db
        .collection('partner_progress')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
