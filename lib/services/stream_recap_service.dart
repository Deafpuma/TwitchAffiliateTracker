import 'package:cloud_firestore/cloud_firestore.dart';

class StreamRecapService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> generateStreamRecap(String userId, int totalViews, int chatMessages, double earnings) async {
    await _db.collection('stream_recaps').add({
      'userId': userId,
      'totalViews': totalViews,
      'chatMessages': chatMessages,
      'earnings': earnings,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getStreamRecaps(String userId) {
    return _db
        .collection('stream_recaps')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
