import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveStreamData(String userId, Map<String, dynamic> streamData) async {
    await _db.collection('stream_history').doc(userId).set({
      'streams': FieldValue.arrayUnion([streamData]),
    }, SetOptions(merge: true));
  }

  Stream<List<Map<String, dynamic>>> getStreamHistory(String userId) {
    return _db.collection('stream_history').doc(userId).snapshots().map(
          (snapshot) {
        if (snapshot.exists) {
          List<dynamic> streams = snapshot.data()?['streams'] ?? [];
          return streams.map((s) => Map<String, dynamic>.from(s)).toList();
        } else {
          return [];
        }
      },
    );
  }
}
