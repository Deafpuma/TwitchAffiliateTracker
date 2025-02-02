import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGoalIncentiveService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createGoalIncentive(String userId, String goalTitle, int target, String reward) async {
    await _db.collection('goal_incentives').add({
      'userId': userId,
      'goalTitle': goalTitle, // Example: "Reach 100 Subs"
      'target': target,
      'reward': reward, // Example: "24-Hour Stream", "Exclusive Giveaway"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGoalIncentives(String userId) {
    return _db
        .collection('goal_incentives')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
