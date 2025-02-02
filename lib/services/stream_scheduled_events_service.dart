import 'package:cloud_firestore/cloud_firestore.dart';

class StreamScheduledEventsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> scheduleEvent(String userId, String eventTitle, DateTime eventDate, String description) async {
    await _db.collection('scheduled_events').add({
      'userId': userId,
      'eventTitle': eventTitle,
      'eventDate': eventDate.toIso8601String(),
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getScheduledEvents(String userId) {
    return _db
        .collection('scheduled_events')
        .where('userId', isEqualTo: userId)
        .orderBy('eventDate', descending: false)
        .snapshots();
  }
}
