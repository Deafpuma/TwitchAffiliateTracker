import 'package:cloud_firestore/cloud_firestore.dart';

class StreamPersonalizedShoutoutsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logShoutout(String userId, String recipientId, String message, String shoutoutType) async {
    await _db.collection('personalized_shoutouts').add({
      'userId': userId,
      'recipientId': recipientId,
      'message': message,
      'shoutoutType': shoutoutType, // Example: "Top Donor", "Loyal Viewer", "Community MVP"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getShoutouts(String userId) {
    return _db
        .collection('personalized_shoutouts')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
