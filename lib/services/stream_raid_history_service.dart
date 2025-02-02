import 'package:cloud_firestore/cloud_firestore.dart';

class StreamRaidHistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logRaid(String userId, String raidedStreamer, int viewerCount, bool isIncoming) async {
    await _db.collection('raid_history').add({
      'userId': userId,
      'raidedStreamer': raidedStreamer,
      'viewerCount': viewerCount,
      'isIncoming': isIncoming,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getRaidHistory(String userId) {
    return _db
        .collection('raid_history')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
