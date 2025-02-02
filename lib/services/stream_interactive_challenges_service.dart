import 'package:cloud_firestore/cloud_firestore.dart';

class StreamInteractiveChallengesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createChallenge(String userId, String challengeTitle, String description, int rewardPoints) async {
    await _db.collection('interactive_challenges').add({
      'userId': userId,
      'challengeTitle': challengeTitle,
      'description': description,
      'rewardPoints': rewardPoints, // Example: "Win a game with no weapons", "Chat flood challenge"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getChallenges(String userId) {
    return _db
        .collection('interactive_challenges')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
