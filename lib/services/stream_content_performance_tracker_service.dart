import 'package:cloud_firestore/cloud_firestore.dart';

class StreamContentPerformanceTrackerService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logContentPerformance(
      String userId, String contentType, int views, int engagementScore) async {
    await _db.collection('content_performance').add({
      'userId': userId,
      'contentType': contentType, // Example: "Just Chatting", "FPS Games", "IRL Streams"
      'views': views,
      'engagementScore': engagementScore, // Custom score based on chat activity, reactions, etc.
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getContentPerformance(String userId) {
    return _db
        .collection('content_performance')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
