import 'package:cloud_firestore/cloud_firestore.dart';

class StreamPersonalizedGoalTrackerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setPersonalGoal(String userId, String goalTitle, int targetAmount, String reward) async {
    await _db.collection('personal_goals').add({
      'userId': userId,
      'goalTitle': goalTitle, // Example: "Stream for 30 Hours", "Reach 500 Followers"
      'targetAmount': targetAmount,
      'reward': reward, // Example: "Special Celebration Stream"
      'progress': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateGoalProgress(String goalId, int progress) async {
    final goalRef = _db.collection('personal_goals').doc(goalId);
    final goalSnapshot = await goalRef.get();
    if (goalSnapshot.exists) {
      int currentProgress = goalSnapshot.data()?['progress'] ?? 0;
      await goalRef.update({'progress': currentProgress + progress});
    }
  }

  Stream<QuerySnapshot> getPersonalGoals(String userId) {
    return _db
        .collection('personal_goals')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
