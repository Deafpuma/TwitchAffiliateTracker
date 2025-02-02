import 'package:cloud_firestore/cloud_firestore.dart';

class WatchPartyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createWatchParty(String hostId, String title, DateTime startTime) async {
    await _db.collection('watch_parties').add({
      'hostId': hostId,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUpcomingWatchParties() {
    return _db.collection('watch_parties')
        .where('startTime', isGreaterThan: DateTime.now().toIso8601String())
        .orderBy('startTime', descending: false)
        .snapshots();
  }
}
