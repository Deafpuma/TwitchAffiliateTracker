import 'package:cloud_firestore/cloud_firestore.dart';

class StreamOverlayCustomizationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveOverlaySettings(String userId, String theme, bool showChat, bool showAlerts) async {
    await _db.collection('overlay_settings').doc(userId).set({
      'theme': theme, // Example: "Dark Mode", "Cyberpunk", "Minimalist"
      'showChat': showChat,
      'showAlerts': showAlerts,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot> getOverlaySettings(String userId) async {
    return await _db.collection('overlay_settings').doc(userId).get();
  }
}
