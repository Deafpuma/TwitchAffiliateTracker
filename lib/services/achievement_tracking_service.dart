import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> unlockAchievement(String userId, String achievementName) async {
    await _db.collection('achievements').add({
      'userId': userId,
      'achievementName': achievementName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserAchievements(String userId) {
    return _db.collection('achievements')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
