import 'package:cloud_firestore/cloud_firestore.dart';

class StreamRevenueService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logRevenue(String userId, double amount, String source) async {
    await _db.collection('stream_revenue').add({
      'userId': userId,
      'amount': amount,
      'source': source,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserRevenue(String userId) {
    return _db.collection('stream_revenue')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
