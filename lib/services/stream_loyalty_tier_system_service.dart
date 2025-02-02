import 'package:cloud_firestore/cloud_firestore.dart';

class StreamLoyaltyTierSystemService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> assignLoyaltyTier(String userId, String viewerId, String tierLevel) async {
    await _db.collection('loyalty_tiers').add({
      'userId': userId,
      'viewerId': viewerId,
      'tierLevel': tierLevel, // Example: "Bronze", "Silver", "Gold", "Platinum"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getLoyaltyTiers(String userId) {
    return _db
        .collection('loyalty_tiers')
        .where('userId', isEqualTo: userId)
        .orderBy('tierLevel', descending: true)
        .snapshots();
  }
}
