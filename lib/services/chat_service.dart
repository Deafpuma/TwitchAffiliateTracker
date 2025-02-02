import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    await _db.collection('messages').add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getMessages(String userId, String chatPartnerId) {
    return _db.collection('messages')
        .where('senderId', whereIn: [userId, chatPartnerId])
        .where('receiverId', whereIn: [userId, chatPartnerId])
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
