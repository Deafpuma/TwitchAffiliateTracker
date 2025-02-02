import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCollaboratorRevenueSharingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logRevenueShare(String userId, String collaboratorId, double amount, String revenueSource) async {
    await _db.collection('collaborator_revenue').add({
      'userId': userId,
      'collaboratorId': collaboratorId,
      'amount': amount,
      'revenueSource': revenueSource, // Example: "Sponsorships", "Affiliate Deals"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getRevenueShares(String userId) {
    return _db
        .collection('collaborator_revenue')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
