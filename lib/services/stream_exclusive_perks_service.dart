import 'package:cloud_firestore/cloud_firestore.dart';

class StreamExclusivePerksService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addExclusivePerk(String userId, String perkTitle, String description, String accessLevel) async {
    await _db.collection('exclusive_perks').add({
      'userId': userId,
      'perkTitle': perkTitle, // Example: "VIP-Only Discord Channel"
      'description': description,
      'accessLevel': accessLevel, // Example: "Subscribers Only", "Tier 3 Only"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getExclusivePerks(String userId) {
    return _db
        .collection('exclusive_perks')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
