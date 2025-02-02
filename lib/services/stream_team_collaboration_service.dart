import 'package:cloud_firestore/cloud_firestore.dart';

class StreamTeamCollaborationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logTeamCollaboration(String teamId, String eventName, DateTime eventDate, String details) async {
    await _db.collection('team_collaborations').add({
      'teamId': teamId,
      'eventName': eventName,
      'eventDate': eventDate.toIso8601String(),
      'details': details,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getTeamCollaborations(String teamId) {
    return _db
        .collection('team_collaborations')
        .where('teamId', isEqualTo: teamId)
        .orderBy('eventDate', descending: false)
        .snapshots();
  }
}
