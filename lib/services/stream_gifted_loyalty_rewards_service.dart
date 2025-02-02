import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGiftedLoyaltyRewardsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> awardLoyaltyReward(String userId, String viewerId, String reward) async {
    await _db.collection('gifted_loyalty_rewards').add({
      'userId': userId,
      'viewerId': viewerId,
      'reward': reward, // Example: "Free 1-month sub", "VIP Badge"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getLoyaltyRewards(String userId) {
    return _db
        .collection('gifted_loyalty_rewards')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
