import 'package:cloud_firestore/cloud_firestore.dart';

class StreamNetworkingEventsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createNetworkingEvent(String userId, String eventName, DateTime eventDate, String description) async {
    await _db.collection('networking_events').add({
      'userId': userId,
      'eventName': eventName,
      'eventDate': eventDate.toIso8601String(),
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getNetworkingEvents(String userId) {
    return _db
        .collection('networking_events')
        .where('userId', isEqualTo: userId)
        .orderBy('eventDate', descending: false)
        .snapshots();
  }
}
