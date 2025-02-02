import 'package:cloud_firestore/cloud_firestore.dart';

class StreamLivePollingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createLivePoll(String userId, String question, List<String> options) async {
    await _db.collection('live_polls').add({
      'userId': userId,
      'question': question,
      'options': options,
      'votes': List.filled(options.length, 0),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> voteOnPoll(String pollId, int optionIndex) async {
    final pollRef = _db.collection('live_polls').doc(pollId);
    final pollSnapshot = await pollRef.get();
    if (pollSnapshot.exists) {
      List<dynamic> votes = pollSnapshot.data()?['votes'];
      votes[optionIndex] += 1;
      await pollRef.update({'votes': votes});
    }
  }

  Stream<QuerySnapshot> getLivePolls(String userId) {
    return _db
        .collection('live_polls')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
