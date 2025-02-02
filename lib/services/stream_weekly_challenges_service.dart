import 'package:cloud_firestore/cloud_firestore.dart';

class StreamWeeklyChallengesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createWeeklyChallenge(String userId, String challengeTitle, int goal, String reward) async {
    await _db.collection('weekly_challenges').add({
      'userId': userId,
      'challengeTitle': challengeTitle,
      'goal': goal, // Example: "Chat must send 500 messages this week!"
      'reward': reward, // Example: "VIP status for top contributor"
      'progress': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateChallengeProgress(String challengeId, int progress) async {
    final challengeRef = _db.collection('weekly_challenges').doc(challengeId);
    final challengeSnapshot = await challengeRef.get();
    if (challengeSnapshot.exists) {
      int currentProgress = challengeSnapshot.data()?['progress'] ?? 0;
      await challengeRef.update({'progress': currentProgress + progress});
    }
  }

  Stream<QuerySnapshot> getWeeklyChallenges(String userId) {
    return _db
        .collection('weekly_challenges')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
