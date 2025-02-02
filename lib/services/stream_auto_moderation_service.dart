import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAutoModerationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addBannedWord(String userId, String word) async {
    await _db.collection('auto_moderation').add({
      'userId': userId,
      'bannedWord': word,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getBannedWords(String userId) {
    return _db
        .collection('auto_moderation')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
