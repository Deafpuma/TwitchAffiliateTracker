import 'package:cloud_firestore/cloud_firestore.dart';

class StreamWeeklyGoalTrackerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setWeeklyGoal(String userId, String goalType, int targetAmount) async {
    await _db.collection('weekly_goals').add({
      'userId': userId,
      'goalType': goalType, // Example: "Hours Streamed", "New Followers"
      'targetAmount': targetAmount,
      'progress': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateGoalProgress(String goalId, int progress) async {
    final goalRef = _db.collection('weekly_goals').doc(goalId);
    final goalSnapshot = await goalRef.get();
    if (goalSnapshot.exists) {
      int currentProgress = goalSnapshot.data()?['progress'] ?? 0;
      await goalRef.update({'progress': currentProgress + progress});
    }
  }

  Stream<QuerySnapshot> getWeeklyGoals(String userId) {
    return _db
        .collection('weekly_goals')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
