import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateLeaderboard(String userId, int supportScore) async {
    await _db.collection('leaderboard').doc(userId).set({
      'userId': userId,
      'supportScore': supportScore,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getLeaderboard() {
    return _db.collection('leaderboard').orderBy('supportScore', descending: true).snapshots();
  }
}
