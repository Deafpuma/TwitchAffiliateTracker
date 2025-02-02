import 'package:cloud_firestore/cloud_firestore.dart';

class SupportersRecognitionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> recognizeSupporter(String userId, String supporterId, String message) async {
    await _db.collection('supporters_recognition').add({
      'userId': userId,
      'supporterId': supporterId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getRecognizedSupporters(String userId) {
    return _db.collection('supporters_recognition')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
