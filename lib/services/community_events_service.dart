import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityEventsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createEvent(String organizerId, String eventName, DateTime eventDate, String details) async {
    await _db.collection('community_events').add({
      'organizerId': organizerId,
      'eventName': eventName,
      'eventDate': eventDate.toIso8601String(),
      'details': details,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUpcomingEvents() {
    return _db.collection('community_events')
        .orderBy('eventDate', descending: false)
        .snapshots();
  }
}
