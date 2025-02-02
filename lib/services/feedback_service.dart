import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submitFeedback(String userId, String feedback) async {
    await _db.collection('feedback').add({
      'userId': userId,
      'feedback': feedback,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
