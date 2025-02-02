import 'package:cloud_firestore/cloud_firestore.dart';

class UserSettingsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateUserSettings(String userId, Map<String, dynamic> settings) async {
    await _db.collection('user_settings').doc(userId).set(settings, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot> getUserSettings(String userId) {
    return _db.collection('user_settings').doc(userId).snapshots();
  }
}
