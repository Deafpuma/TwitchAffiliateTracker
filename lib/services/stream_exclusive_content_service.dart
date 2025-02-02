import 'package:cloud_firestore/cloud_firestore.dart';

class StreamExclusiveContentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addExclusiveContent(String userId, String contentTitle, String contentUrl, String accessLevel) async {
    await _db.collection('exclusive_content').add({
      'userId': userId,
      'contentTitle': contentTitle, // Example: "Behind the Scenes", "VIP Streams"
      'contentUrl': contentUrl,
      'accessLevel': accessLevel, // Example: "Subscribers Only", "VIP Members"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getExclusiveContent(String userId) {
    return _db
        .collection('exclusive_content')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
