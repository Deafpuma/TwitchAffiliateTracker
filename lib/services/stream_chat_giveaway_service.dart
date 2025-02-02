import 'package:cloud_firestore/cloud_firestore.dart';

class StreamChatGiveawayService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> startGiveaway(String userId, String giveawayTitle, int requiredMessages) async {
    await _db.collection('chat_giveaways').add({
      'userId': userId,
      'giveawayTitle': giveawayTitle,
      'requiredMessages': requiredMessages, // Example: Minimum chat messages to enter
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getChatGiveaways(String userId) {
    return _db
        .collection('chat_giveaways')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
