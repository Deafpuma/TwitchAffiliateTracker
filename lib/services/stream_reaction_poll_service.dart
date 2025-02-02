import 'package:cloud_firestore/cloud_firestore.dart';

class StreamReactionPollService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createReactionPoll(String userId, String question, List<String> reactions) async {
    await _db.collection('reaction_polls').add({
      'userId': userId,
      'question': question,
      'reactions': reactions, // Example: ["😂", "🔥", "👎"]
      'votes': List.filled(reactions.length, 0),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> voteOnPoll(String pollId, int reactionIndex) async {
    final pollRef = _db.collection('reaction_polls').doc(pollId);
    final pollSnapshot = await pollRef.get();
    if (pollSnapshot.exists) {
      List<dynamic> votes = pollSnapshot.data()?['votes'];
      votes[reactionIndex] += 1;
      await pollRef.update({'votes': votes});
    }
  }

  Stream<QuerySnapshot> getReactionPolls(String userId) {
    return _db
        .collection('reaction_polls')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
