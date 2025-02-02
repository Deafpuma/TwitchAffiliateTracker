import 'package:cloud_firestore/cloud_firestore.dart';

class StreamMilestoneAnnouncementService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logMilestone(String userId, String milestoneType, String milestoneMessage) async {
    await _db.collection('milestone_announcements').add({
      'userId': userId,
      'milestoneType': milestoneType, // Example: "100 Followers", "First Payout"
      'milestoneMessage': milestoneMessage,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMilestoneAnnouncements(String userId) {
    return _db
        .collection('milestone_announcements')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
