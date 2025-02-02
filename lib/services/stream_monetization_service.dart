import 'package:cloud_firestore/cloud_firestore.dart';

class StreamMonetizationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logMonetization(String userId, String incomeSource, double amount) async {
    await _db.collection('stream_monetization').add({
      'userId': userId,
      'incomeSource': incomeSource, // Example: "Ad Revenue", "Sponsorship", "Donations"
      'amount': amount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMonetizationLogs(String userId) {
    return _db
        .collection('stream_monetization')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
