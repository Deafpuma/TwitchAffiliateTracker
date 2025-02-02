import 'package:cloud_firestore/cloud_firestore.dart';

class ViewerGiveawayEntryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> enterGiveaway(String userId, String giveawayId, String viewerId) async {
    await _db.collection('giveaway_entries').add({
      'userId': userId,
      'giveawayId': giveawayId,
      'viewerId': viewerId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGiveawayEntries(String giveawayId) {
    return _db
        .collection('giveaway_entries')
        .where('giveawayId', isEqualTo: giveawayId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
