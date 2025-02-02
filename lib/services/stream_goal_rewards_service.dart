import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGoalRewardsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> assignGoalReward(String userId, String goalType, String rewardDescription) async {
    await _db.collection('goal_rewards').add({
      'userId': userId,
      'goalType': goalType, // Example: "100 Followers", "50 Subs"
      'rewardDescription': rewardDescription,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGoalRewards(String userId) {
    return _db
        .collection('goal_rewards')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
