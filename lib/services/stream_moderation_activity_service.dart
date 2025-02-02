import 'package:cloud_firestore/cloud_firestore.dart';

class StreamModerationActivityService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logModerationAction(String userId, String actionType, String targetUser, String reason) async {
    await _db.collection('moderation_activity').add({
      'userId': userId,
      'actionType': actionType, // Example: "Ban", "Timeout", "Delete Message"
      'targetUser': targetUser,
      'reason': reason,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getModerationLogs(String userId) {
    return _db
        .collection('moderation_activity')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
