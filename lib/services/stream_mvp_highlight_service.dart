import 'package:cloud_firestore/cloud_firestore.dart';

class StreamMVPHighlightService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> highlightMVP(String userId, String viewerId, String reason) async {
    await _db.collection('mvp_highlights').add({
      'userId': userId,
      'viewerId': viewerId,
      'reason': reason, // Example: "Top donor", "Most active in chat"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMVPs(String userId) {
    return _db
        .collection('mvp_highlights')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
