import 'package:cloud_firestore/cloud_firestore.dart';

class StreamTeamService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createTeam(String teamName, String ownerId) async {
    await _db.collection('stream_teams').add({
      'teamName': teamName,
      'ownerId': ownerId,
      'members': [ownerId],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> joinTeam(String teamId, String userId) async {
    final teamRef = _db.collection('stream_teams').doc(teamId);
    final teamSnapshot = await teamRef.get();

    if (teamSnapshot.exists) {
      List<dynamic> members = teamSnapshot.data()?['members'] ?? [];
      if (!members.contains(userId)) {
        members.add(userId);
        await teamRef.update({'members': members});
      }
    }
  }

  Future<void> leaveTeam(String teamId, String userId) async {
    final teamRef = _db.collection('stream_teams').doc(teamId);
    final teamSnapshot = await teamRef.get();

    if (teamSnapshot.exists) {
      List<dynamic> members = teamSnapshot.data()?['members'] ?? [];
      members.remove(userId);
      await teamRef.update({'members': members});
    }
  }

  Stream<QuerySnapshot> getTeams() {
    return _db.collection('stream_teams')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
