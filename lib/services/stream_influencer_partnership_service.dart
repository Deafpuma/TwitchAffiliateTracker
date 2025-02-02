import 'package:cloud_firestore/cloud_firestore.dart';

class StreamInfluencerPartnershipService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logPartnership(
      String userId, String influencerName, String partnershipDetails, double payoutAmount) async {
    await _db.collection('influencer_partnerships').add({
      'userId': userId,
      'influencerName': influencerName,
      'partnershipDetails': partnershipDetails,
      'payoutAmount': payoutAmount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getInfluencerPartnerships(String userId) {
    return _db
        .collection('influencer_partnerships')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
