import 'package:cloud_firestore/cloud_firestore.dart';

class StreamMilestoneService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logMilestone(String userId, String milestoneType, String milestoneDescription, int milestoneValue) async {
    await _db.collection('stream_milestones').add({
      'userId': userId,
      'milestoneType': milestoneType,
      'milestoneDescription': milestoneDescription,
      'milestoneValue': milestoneValue,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserMilestones(String userId) {
    return _db
        .collection('stream_milestones')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
