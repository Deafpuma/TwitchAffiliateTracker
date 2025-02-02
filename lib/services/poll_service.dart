import 'package:cloud_firestore/cloud_firestore.dart';

class PollService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPoll(String creatorId, String question, List<String> options) async {
    await _db.collection('polls').add({
      'creatorId': creatorId,
      'question': question,
      'options': options,
      'votes': List.filled(options.length, 0),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> votePoll(String pollId, int optionIndex) async {
    final pollRef = _db.collection('polls').doc(pollId);
    final pollSnapshot = await pollRef.get();
    if (pollSnapshot.exists) {
      List<dynamic> votes = pollSnapshot['votes'];
      votes[optionIndex] += 1;
      await pollRef.update({'votes': votes});
    }
  }

  Stream<QuerySnapshot> getActivePolls() {
    return _db.collection('polls')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
