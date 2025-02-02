import 'package:cloud_firestore/cloud_firestore.dart';

class StreamDuoPartnerTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logDuoSession(String userId, String partnerId, String gamePlayed, int sharedViewers) async {
    await _db.collection('duo_partners').add({
      'userId': userId,
      'partnerId': partnerId,
      'gamePlayed': gamePlayed,
      'sharedViewers': sharedViewers,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getDuoSessions(String userId) {
    return _db
        .collection('duo_partners')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
