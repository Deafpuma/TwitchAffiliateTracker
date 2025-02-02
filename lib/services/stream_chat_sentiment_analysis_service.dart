import 'package:cloud_firestore/cloud_firestore.dart';

class StreamChatSentimentAnalysisService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logChatSentiment(String userId, int positive, int neutral, int negative) async {
    await _db.collection('chat_sentiment_analysis').add({
      'userId': userId,
      'positive': positive,
      'neutral': neutral,
      'negative': negative,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getChatSentimentStats(String userId) {
    return _db
        .collection('chat_sentiment_analysis')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
