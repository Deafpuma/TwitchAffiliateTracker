import 'package:cloud_firestore/cloud_firestore.dart';

class NetworkGrowthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logNetworkingActivity(String userId, String collaboratorId, String activityType, String details) async {
    await _db.collection('network_growth').add({
      'userId': userId,
      'collaboratorId': collaboratorId,
      'activityType': activityType,
      'details': details,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getNetworkingLogs(String userId) {
    return _db
        .collection('network_growth')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
