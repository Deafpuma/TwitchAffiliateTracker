import 'package:cloud_firestore/cloud_firestore.dart';

class VIPMembershipService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addVIPMember(String userId, String vipLevel, DateTime startDate) async {
    await _db.collection('vip_memberships').add({
      'userId': userId,
      'vipLevel': vipLevel,
      'startDate': startDate.toIso8601String(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getVIPMembers() {
    return _db.collection('vip_memberships')
        .orderBy('startDate', descending: true)
        .snapshots();
  }
}
