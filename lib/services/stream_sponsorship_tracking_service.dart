import 'package:cloud_firestore/cloud_firestore.dart';

class StreamSponsorshipTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logSponsorshipDeal(String userId, String sponsorName, double amountEarned, String campaignDetails) async {
    await _db.collection('sponsorship_tracking').add({
      'userId': userId,
      'sponsorName': sponsorName,
      'amountEarned': amountEarned,
      'campaignDetails': campaignDetails,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSponsorshipStats(String userId) {
    return _db
        .collection('sponsorship_tracking')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
