import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGiftedSubTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logGiftedSub(String userId, String gifterId, int subCount) async {
    await _db.collection('gifted_subs').add({
      'userId': userId,
      'gifterId': gifterId,
      'subCount': subCount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGiftedSubs(String userId) {
    return _db
        .collection('gifted_subs')
        .where('userId', isEqualTo: userId)
        .orderBy('subCount', descending: true)
        .snapshots();
  }
}
