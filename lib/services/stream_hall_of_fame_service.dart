import 'package:cloud_firestore/cloud_firestore.dart';

class StreamHallOfFameService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addHallOfFameMember(String userId, String viewerId, String reason) async {
    await _db.collection('hall_of_fame').add({
      'userId': userId,
      'viewerId': viewerId,
      'reason': reason, // Example: "Top Donator", "Most Active Viewer"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getHallOfFameMembers(String userId) {
    return _db
        .collection('hall_of_fame')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
