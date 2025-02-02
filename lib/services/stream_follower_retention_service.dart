import 'package:cloud_firestore/cloud_firestore.dart';

class StreamFollowerRetentionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logFollowerRetention(String userId, int newFollowers, int returningFollowers) async {
    await _db.collection('follower_retention').add({
      'userId': userId,
      'newFollowers': newFollowers,
      'returningFollowers': returningFollowers,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getFollowerRetentionStats(String userId) {
    return _db
        .collection('follower_retention')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
