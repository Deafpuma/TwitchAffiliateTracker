import 'package:cloud_firestore/cloud_firestore.dart';

class StreamReviewFeedbackService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submitFeedback(String userId, String streamId, String feedbackText, int rating) async {
    await _db.collection('stream_feedback').add({
      'userId': userId,
      'streamId': streamId,
      'feedbackText': feedbackText,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserFeedback(String userId) {
    return _db
        .collection('stream_feedback')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
