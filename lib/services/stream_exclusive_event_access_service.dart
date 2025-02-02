import 'package:cloud_firestore/cloud_firestore.dart';

class StreamExclusiveEventAccessService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createExclusiveEvent(String userId, String eventTitle, DateTime eventDate, String accessLevel) async {
    await _db.collection('exclusive_events').add({
      'userId': userId,
      'eventTitle': eventTitle,
      'eventDate': eventDate.toIso8601String(),
      'accessLevel': accessLevel, // Example: "Subscribers Only", "VIP Members"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getExclusiveEvents(String userId) {
    return _db
        .collection('exclusive_events')
        .where('userId', isEqualTo: userId)
        .orderBy('eventDate', descending: false)
        .snapshots();
  }
}
