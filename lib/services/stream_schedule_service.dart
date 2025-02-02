import 'package:cloud_firestore/cloud_firestore.dart';

class StreamScheduleService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addStreamSchedule(String userId, DateTime scheduledTime, String title) async {
    await _db.collection('stream_schedules').add({
      'userId': userId,
      'scheduledTime': scheduledTime.toIso8601String(),
      'title': title,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserSchedule(String userId) {
    return _db.collection('stream_schedules')
        .where('userId', isEqualTo: userId)
        .orderBy('scheduledTime', descending: false)
        .snapshots();
  }
}
