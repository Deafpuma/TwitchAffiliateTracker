import 'package:cloud_firestore/cloud_firestore.dart';

class TierRewardsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addReward(String tierLevel, String rewardDescription) async {
    await _db.collection('tier_rewards').add({
      'tierLevel': tierLevel,
      'rewardDescription': rewardDescription,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getTierRewards() {
    return _db.collection('tier_rewards')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
