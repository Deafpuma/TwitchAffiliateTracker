import 'package:cloud_firestore/cloud_firestore.dart';

class StreamAlertsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addAlert(String userId, String alertMessage) async {
    await _db.collection('stream_alerts').add({
      'userId': userId,
      'alertMessage': alertMessage,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserAlerts(String userId) {
    return _db.collection('stream_alerts')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
