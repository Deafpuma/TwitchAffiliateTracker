import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCollaborationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logCollaboration(String userId, String collaboratorId, String streamTitle) async {
    await _db.collection('stream_collaborations').add({
      'userId': userId,
      'collaboratorId': collaboratorId,
      'streamTitle': streamTitle,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getCollaborations(String userId) {
    return _db
        .collection('stream_collaborations')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
