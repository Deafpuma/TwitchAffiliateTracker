import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriberGrowthTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logSubscriberGrowth(String userId, int newSubscribers) async {
    await _db.collection('subscriber_growth').add({
      'userId': userId,
      'newSubscribers': newSubscribers,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSubscriberGrowthLogs(String userId) {
    return _db
        .collection('subscriber_growth')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
