import 'package:cloud_firestore/cloud_firestore.dart';

class StreamInfluencerCollabTrackerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logCollaboration(String userId, String influencerName, String collabType, String outcome) async {
    await _db.collection('influencer_collaborations').add({
      'userId': userId,
      'influencerName': influencerName,
      'collabType': collabType, // Example: "Co-Stream", "Brand Partnership"
      'outcome': outcome, // Example: "Increased Follower Growth"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getCollaborations(String userId) {
    return _db
        .collection('influencer_collaborations')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
