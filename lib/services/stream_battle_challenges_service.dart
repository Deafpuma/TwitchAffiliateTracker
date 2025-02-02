import 'package:cloud_firestore/cloud_firestore.dart';

class StreamBattleChallengesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createBattleChallenge(String userId, String challengeTitle, String rules, int rewardPoints) async {
    await _db.collection('battle_challenges').add({
      'userId': userId,
      'challengeTitle': challengeTitle,
      'rules': rules,
      'rewardPoints': rewardPoints, // Example: "Win 3 games in a row", "Top chat participant"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getBattleChallenges(String userId) {
    return _db
        .collection('battle_challenges')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
