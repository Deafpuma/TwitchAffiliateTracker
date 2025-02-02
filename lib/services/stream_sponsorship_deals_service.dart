import 'package:cloud_firestore/cloud_firestore.dart';

class StreamSponsorshipDealsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logSponsorshipDeal(
      String userId, String sponsorName, double dealAmount, String contractDetails) async {
    await _db.collection('sponsorship_deals').add({
      'userId': userId,
      'sponsorName': sponsorName,
      'dealAmount': dealAmount,
      'contractDetails': contractDetails,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSponsorshipDeals(String userId) {
    return _db
        .collection('sponsorship_deals')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
