import 'package:cloud_firestore/cloud_firestore.dart';

class StreamTournamentTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createTournament(String userId, String tournamentName, DateTime startDate, String prizePool) async {
    await _db.collection('tournaments').add({
      'userId': userId,
      'tournamentName': tournamentName,
      'startDate': startDate.toIso8601String(),
      'prizePool': prizePool,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getTournaments(String userId) {
    return _db
        .collection('tournaments')
        .where('userId', isEqualTo: userId)
        .orderBy('startDate', descending: false)
        .snapshots();
  }
}
