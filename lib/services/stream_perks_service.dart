import 'package:cloud_firestore/cloud_firestore.dart';

class StreamPerksService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addPerk(String userId, String perkTitle, String description) async {
    await _db.collection('stream_perks').add({
      'userId': userId,
      'perkTitle': perkTitle,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserPerks(String userId) {
    return _db
        .collection('stream_perks')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
