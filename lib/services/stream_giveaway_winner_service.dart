import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGiveawayWinnerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logGiveawayWinner(String userId, String giveawayId, String winnerId, String prize) async {
    await _db.collection('giveaway_winners').add({
      'userId': userId,
      'giveawayId': giveawayId,
      'winnerId': winnerId,
      'prize': prize, // Example: "Twitch Gift Sub", "Merch", "Cash Prize"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGiveawayWinners(String userId) {
    return _db
        .collection('giveaway_winners')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
