import 'package:cloud_firestore/cloud_firestore.dart';

class StreamHypeTrainTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logHypeTrain(String userId, int level, int participants, double totalDonations) async {
    await _db.collection('hype_trains').add({
      'userId': userId,
      'level': level, // Example: Hype Train Level 1, 2, 3, etc.
      'participants': participants,
      'totalDonations': totalDonations,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getHypeTrainStats(String userId) {
    return _db
        .collection('hype_trains')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
