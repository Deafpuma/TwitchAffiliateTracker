import 'package:cloud_firestore/cloud_firestore.dart';

class ViewerSubscriberAnniversaryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logSubscriberAnniversary(String userId, String viewerId, int monthsSubscribed) async {
    await _db.collection('subscriber_anniversaries').add({
      'userId': userId,
      'viewerId': viewerId,
      'monthsSubscribed': monthsSubscribed,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSubscriberAnniversaries(String userId) {
    return _db
        .collection('subscriber_anniversaries')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
