import 'package:cloud_firestore/cloud_firestore.dart';

class StreamEmoteLeaderboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logEmoteUsage(String userId, String emote, int usageCount) async {
    await _db.collection('emote_leaderboard').doc(emote).set({
      'userId': userId,
      'emote': emote, // Example: "PogChamp", "LUL", "Kappa"
      'usageCount': usageCount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getEmoteLeaderboard(String userId) {
    return _db
        .collection('emote_leaderboard')
        .where('userId', isEqualTo: userId)
        .orderBy('usageCount', descending: true)
        .snapshots();
  }
}
