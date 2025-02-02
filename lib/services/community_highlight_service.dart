import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityHighlightService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addHighlight(String userId, String message) async {
    await _db.collection('community_highlights').add({
      'userId': userId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getHighlights() {
    return _db.collection('community_highlights').orderBy('timestamp', descending: true).snapshots();
  }
}
