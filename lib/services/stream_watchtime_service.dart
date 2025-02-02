import 'package:cloud_firestore/cloud_firestore.dart';

class StreamWatchtimeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logWatchTime(String userId, String viewerId, int minutesWatched) async {
    await _db.collection('stream_watchtime').add({
      'userId': userId,
      'viewerId': viewerId,
      'minutesWatched': minutesWatched,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getWatchtimeLogs(String userId) {
    return _db
        .collection('stream_watchtime')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
