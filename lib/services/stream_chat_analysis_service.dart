import 'package:cloud_firestore/cloud_firestore.dart';

class StreamChatAnalysisService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logChatActivity(String userId, int totalMessages, int uniqueUsers, int emoteUsage) async {
    await _db.collection('stream_chat_analysis').add({
      'userId': userId,
      'totalMessages': totalMessages,
      'uniqueUsers': uniqueUsers,
      'emoteUsage': emoteUsage,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getChatAnalysis(String userId) {
    return _db
        .collection('stream_chat_analysis')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

