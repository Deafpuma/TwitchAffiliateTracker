import 'package:cloud_firestore/cloud_firestore.dart';

class StreamSponsorPromotionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logSponsorPromotion(
      String userId, String sponsorName, String promotionDetails, double payoutAmount) async {
    await _db.collection('sponsor_promotions').add({
      'userId': userId,
      'sponsorName': sponsorName,
      'promotionDetails': promotionDetails,
      'payoutAmount': payoutAmount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSponsorPromotions(String userId) {
    return _db
        .collection('sponsor_promotions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
