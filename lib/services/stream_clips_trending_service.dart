import 'package:cloud_firestore/cloud_firestore.dart';

class StreamClipsTrendingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logTrendingClip(String userId, String clipUrl, int views, int shares, int likes) async {
    await _db.collection('trending_clips').add({
      'userId': userId,
      'clipUrl': clipUrl,
      'views': views,
      'shares': shares,
      'likes': likes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getTrendingClips(String userId) {
    return _db
        .collection('trending_clips')
        .where('userId', isEqualTo: userId)
        .orderBy('views', descending: true)
        .snapshots();
  }
}
