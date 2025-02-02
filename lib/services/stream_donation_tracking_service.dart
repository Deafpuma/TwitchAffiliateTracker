import 'package:cloud_firestore/cloud_firestore.dart';

class StreamDonationTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logDonation(String userId, String donorName, double amount, String message) async {
    await _db.collection('stream_donations').add({
      'userId': userId,
      'donorName': donorName,
      'amount': amount,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserDonations(String userId) {
    return _db
        .collection('stream_donations')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
