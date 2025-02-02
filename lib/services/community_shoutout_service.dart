import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityShoutoutService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendShoutout(String userId, String recipientId, String message) async {
    await _db.collection('community_shoutouts').add({
      'userId': userId,
      'recipientId': recipientId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserShoutouts(String recipientId) {
    return _db
        .collection('community_shoutouts')
        .where('recipientId', isEqualTo: recipientId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
