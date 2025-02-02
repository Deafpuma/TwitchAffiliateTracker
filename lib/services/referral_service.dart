import 'package:cloud_firestore/cloud_firestore.dart';

class ReferralService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addReferral(String referrerId, String referredUserId) async {
    await _db.collection('referrals').add({
      'referrerId': referrerId,
      'referredUserId': referredUserId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<int> getReferralCount(String userId) async {
    final querySnapshot = await _db.collection('referrals').where('referrerId', isEqualTo: userId).get();
    return querySnapshot.docs.length;
  }
}
