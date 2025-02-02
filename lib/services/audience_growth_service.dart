import 'package:cloud_firestore/cloud_firestore.dart';

class AudienceGrowthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logGrowth(String userId, int newFollowers, int totalViewers) async {
    await _db.collection('audience_growth').add({
      'userId': userId,
      'newFollowers': newFollowers,
      'totalViewers': totalViewers,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserGrowth(String userId) {
    return _db.collection('audience_growth')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
