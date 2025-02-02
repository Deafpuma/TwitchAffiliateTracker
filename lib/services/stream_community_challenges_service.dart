import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCommunityChallengesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createChallenge(String userId, String challengeTitle, int goal, String reward) async {
    await _db.collection('community_challenges').add({
      'userId': userId,
      'challengeTitle': challengeTitle,
      'goal': goal, // Example: "Reach 500 total chat messages"
      'reward': reward, // Example: "Special giveaway"
      'progress': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateChallengeProgress(String challengeId, int progress) async {
    final challengeRef = _db.collection('community_challenges').doc(challengeId);
    final challengeSnapshot = await challengeRef.get();
    if (challengeSnapshot.exists) {
      int currentProgress = challengeSnapshot.data()?['progress'] ?? 0;
      await challengeRef.update({'progress': currentProgress + progress});
    }
  }

  Stream<QuerySnapshot> getChallenges(String userId) {
    return _db
        .collection('community_challenges')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
