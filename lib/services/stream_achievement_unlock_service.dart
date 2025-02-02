import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAchievementUnlockService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> unlockAchievement(String userId, String achievementName, String description) async {
    await _db.collection('stream_achievements').add({
      'userId': userId,
      'achievementName': achievementName,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserAchievements(String userId) {
    return _db
        .collection('stream_achievements')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
