import 'package:cloud_firestore/cloud_firestore.dart';

class SponsorshipTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logSponsorshipPerformance(
      String userId, String sponsorName, double revenueGenerated, int views) async {
    await _db.collection('sponsorship_logs').add({
      'userId': userId,
      'sponsorName': sponsorName,
      'revenueGenerated': revenueGenerated,
      'views': views,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSponsorshipLogs(String userId) {
    return _db
        .collection('sponsorship_logs')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
