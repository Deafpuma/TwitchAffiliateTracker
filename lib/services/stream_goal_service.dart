import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGoalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setStreamGoal(String userId, String goalTitle, int targetValue) async {
    await _db.collection('stream_goals').add({
      'userId': userId,
      'goalTitle': goalTitle,
      'targetValue': targetValue,
      'progress': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateProgress(String goalId, int newProgress) async {
    await _db.collection('stream_goals').doc(goalId).update({
      'progress': newProgress,
    });
  }

  Stream<QuerySnapshot> getUserGoals(String userId) {
    return _db.collection('stream_goals')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
