import 'package:cloud_firestore/cloud_firestore.dart';

class StreamHighlightClipsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveClip(String userId, String clipUrl, String clipTitle) async {
    await _db.collection('stream_highlight_clips').add({
      'userId': userId,
      'clipUrl': clipUrl,
      'clipTitle': clipTitle,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserClips(String userId) {
    return _db
        .collection('stream_highlight_clips')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
