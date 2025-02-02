import 'package:cloud_firestore/cloud_firestore.dart';

class ViewerInteractionTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logViewerInteraction(
      String userId, String viewerId, String interactionType) async {
    await _db.collection('viewer_interactions').add({
      'userId': userId,
      'viewerId': viewerId,
      'interactionType': interactionType, // Example: "Follow", "Subscription", "Chat Message"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getViewerInteractions(String userId) {
    return _db
        .collection('viewer_interactions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
