import 'package:cloud_firestore/cloud_firestore.dart';

class StreamTriviaQuizService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createTriviaQuiz(String userId, String question, List<String> options, int correctAnswerIndex) async {
    await _db.collection('trivia_quizzes').add({
      'userId': userId,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getTriviaQuizzes(String userId) {
    return _db
        .collection('trivia_quizzes')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
