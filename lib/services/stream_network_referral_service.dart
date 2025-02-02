import 'package:cloud_firestore/cloud_firestore.dart';

class StreamNetworkReferralService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logReferral(String userId, String referredStreamerId) async {
    await _db.collection('network_referrals').add({
      'userId': userId,
      'referredStreamerId': referredStreamerId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getReferrals(String userId) {
    return _db
        .collection('network_referrals')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
