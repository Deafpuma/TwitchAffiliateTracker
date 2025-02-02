import 'package:cloud_firestore/cloud_firestore.dart';

class StreamReactionTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logReaction(String userId, String reactionType, int count) async {
    await _db.collection('stream_reactions').add({
      'userId': userId,
      'reactionType': reactionType, // Example: "Cheer", "Sound Alert", "Hype Emote"
      'count': count,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getReactionStats(String userId) {
    return _db
        .collection('stream_reactions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
