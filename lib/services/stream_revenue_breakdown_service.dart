import 'package:cloud_firestore/cloud_firestore.dart';

class StreamRevenueBreakdownService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logRevenue(String userId, String revenueSource, double amount) async {
    await _db.collection('revenue_breakdown').add({
      'userId': userId,
      'revenueSource': revenueSource, // Example: "Subscriptions", "Donations", "Sponsorships"
      'amount': amount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getRevenueBreakdown(String userId) {
    return _db
        .collection('revenue_breakdown')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
