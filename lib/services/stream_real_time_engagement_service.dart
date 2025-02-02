import 'package:cloud_firestore/cloud_firestore.dart';

class StreamRealTimeEngagementService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logEngagement(String userId, int chatMessages, int reactions, int uniqueParticipants) async {
    await _db.collection('real_time_engagement').add({
      'userId': userId,
      'chatMessages': chatMessages,
      'reactions': reactions,
      'uniqueParticipants': uniqueParticipants, // Unique viewers engaging in chat
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getRealTimeEngagement(String userId) {
    return _db
        .collection('real_time_engagement')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
