import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGoalProgressService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logGoalProgress(String userId, String goalType, int progress, int goalTarget) async {
    await _db.collection('stream_goal_progress').add({
      'userId': userId,
      'goalType': goalType, // Example: "Followers", "Revenue", "Stream Hours"
      'progress': progress,
      'goalTarget': goalTarget,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGoalProgress(String userId) {
    return _db
        .collection('stream_goal_progress')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
