import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCustomCommandsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addCustomCommand(String userId, String command, String response) async {
    await _db.collection('custom_commands').add({
      'userId': userId,
      'command': command, // Example: "!uptime", "!socials"
      'response': response, // Example: "I've been live for X hours!"
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getCustomCommands(String userId) {
    return _db
        .collection('custom_commands')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
