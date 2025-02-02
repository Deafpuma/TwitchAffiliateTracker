import 'package:cloud_firestore/cloud_firestore.dart';

class StreamContentStrategyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logContentStrategy(
      String userId, String contentType, int engagementScore, String improvementSuggestions) async {
    await _db.collection('content_strategy').add({
      'userId': userId,
      'contentType': contentType, // Example: "Gaming", "Just Chatting"
      'engagementScore': engagementScore,
      'improvementSuggestions': improvementSuggestions,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getContentStrategyLogs(String userId) {
    return _db
        .collection('content_strategy')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
