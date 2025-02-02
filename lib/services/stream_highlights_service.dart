import 'package:cloud_firestore/cloud_firestore.dart';

class StreamHighlightsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addHighlight(String userId, String highlightTitle, String highlightUrl) async {
    await _db.collection('stream_highlights').add({
      'userId': userId,
      'highlightTitle': highlightTitle,
      'highlightUrl': highlightUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserHighlights(String userId) {
    return _db.collection('stream_highlights')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
