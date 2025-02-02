import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAffiliateProgressService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logAffiliateProgress(String userId, int avgViewers, int totalStreamHours, int uniqueDaysStreamed) async {
    await _db.collection('affiliate_progress').add({
      'userId': userId,
      'avgViewers': avgViewers,
      'totalStreamHours': totalStreamHours,
      'uniqueDaysStreamed': uniqueDaysStreamed,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAffiliateProgress(String userId) {
    return _db
        .collection('affiliate_progress')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
