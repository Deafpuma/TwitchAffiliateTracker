import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAlertsNotificationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendStreamAlert(String userId, String alertType, String message) async {
    await _db.collection('stream_alerts').add({
      'userId': userId,
      'alertType': alertType, // Example: "New Follower", "Donation", "Raid"
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getStreamAlerts(String userId) {
    return _db
        .collection('stream_alerts')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
