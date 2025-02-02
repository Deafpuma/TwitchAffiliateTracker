import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCommunityHighlightService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> highlightCommunityMember(String userId, String viewerId, String reason) async {
    await _db.collection('community_highlights').add({
      'userId': userId,
      'viewerId': viewerId,
      'reason': reason, // Example: "Most Helpful Mod", "Top Contributor"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getCommunityHighlights(String userId) {
    return _db
        .collection('community_highlights')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
