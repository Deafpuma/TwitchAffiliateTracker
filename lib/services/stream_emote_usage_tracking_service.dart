import 'package:cloud_firestore/cloud_firestore.dart';

class StreamEmoteUsageTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logEmoteUsage(String userId, String emote, int usageCount) async {
    await _db.collection('emote_usage').add({
      'userId': userId,
      'emote': emote, // Example: "PogChamp", "Kappa"
      'usageCount': usageCount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getEmoteUsageStats(String userId) {
    return _db
        .collection('emote_usage')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
