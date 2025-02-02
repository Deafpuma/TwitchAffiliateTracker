import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCommunityInitiativesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createInitiative(String userId, String initiativeTitle, String description, String goal) async {
    await _db.collection('community_initiatives').add({
      'userId': userId,
      'initiativeTitle': initiativeTitle,
      'description': description,
      'goal': goal, // Example: "Raise $1,000 for a charity", "Host a 12-hour community event"
      'progress': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateInitiativeProgress(String initiativeId, int progress) async {
    final initiativeRef = _db.collection('community_initiatives').doc(initiativeId);
    final initiativeSnapshot = await initiativeRef.get();
    if (initiativeSnapshot.exists) {
      int currentProgress = initiativeSnapshot.data()?['progress'] ?? 0;
      await initiativeRef.update({'progress': currentProgress + progress});
    }
  }

  Stream<QuerySnapshot> getInitiatives(String userId) {
    return _db
        .collection('community_initiatives')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
