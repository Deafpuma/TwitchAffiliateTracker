import 'package:cloud_firestore/cloud_firestore.dart';

class StreamHolidayEventsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createHolidayEvent(String userId, String eventName, DateTime eventDate, String description) async {
    await _db.collection('holiday_events').add({
      'userId': userId,
      'eventName': eventName,
      'eventDate': eventDate.toIso8601String(),
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getHolidayEvents(String userId) {
    return _db
        .collection('holiday_events')
        .where('userId', isEqualTo: userId)
        .orderBy('eventDate', descending: false)
        .snapshots();
  }
}
