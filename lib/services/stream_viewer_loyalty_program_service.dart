import 'package:cloud_firestore/cloud_firestore.dart';

class StreamViewerLoyaltyProgramService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addLoyaltyPoints(String userId, String viewerId, int points) async {
    await _db.collection('viewer_loyalty').add({
      'userId': userId,
      'viewerId': viewerId,
      'points': points,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getViewerLoyaltyPoints(String userId) {
    return _db
        .collection('viewer_loyalty')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
