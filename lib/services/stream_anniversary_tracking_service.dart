import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAnniversaryTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logAnniversary(String userId, DateTime streamStartDate, int yearsStreaming) async {
    await _db.collection('stream_anniversaries').add({
      'userId': userId,
      'streamStartDate': streamStartDate.toIso8601String(),
      'yearsStreaming': yearsStreaming,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAnniversaryData(String userId) {
    return _db
        .collection('stream_anniversaries')
        .where('userId', isEqualTo: userId)
        .orderBy('yearsStreaming', descending: true)
        .snapshots();
  }
}
