import 'package:cloud_firestore/cloud_firestore.dart';

class CollaborationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> proposeCollaboration(String userId, String collaboratorId, String details) async {
    await _db.collection('collaborations').add({
      'userId': userId,
      'collaboratorId': collaboratorId,
      'details': details,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserCollaborations(String userId) {
    return _db.collection('collaborations')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
