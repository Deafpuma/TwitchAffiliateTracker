import 'package:cloud_firestore/cloud_firestore.dart';

class StreamSocialSharingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logSocialShare(String userId, String platform, int shares, int likes) async {
    await _db.collection('social_shares').add({
      'userId': userId,
      'platform': platform, // Example: "Twitter", "Instagram", "Reddit"
      'shares': shares,
      'likes': likes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSocialShares(String userId) {
    return _db
        .collection('social_shares')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
