import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCommunityVoteService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createVote(String userId, String question, List<String> options) async {
    await _db.collection('community_votes').add({
      'userId': userId,
      'question': question,
      'options': options,
      'votes': List.filled(options.length, 0),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> vote(String voteId, int optionIndex) async {
    final voteRef = _db.collection('community_votes').doc(voteId);
    final voteSnapshot = await voteRef.get();
    if (voteSnapshot.exists) {
      List<dynamic> votes = voteSnapshot.data()?['votes'];
      votes[optionIndex] += 1;
      await voteRef.update({'votes': votes});
    }
  }

  Stream<QuerySnapshot> getVotes(String userId) {
    return _db
        .collection('community_votes')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

