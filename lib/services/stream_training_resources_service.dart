import 'package:cloud_firestore/cloud_firestore.dart';

class StreamTrainingResourcesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTrainingResource(String title, String description, String link) async {
    await _db.collection('training_resources').add({
      'title': title,
      'description': description,
      'link': link,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getTrainingResources() {
    return _db
        .collection('training_resources')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
