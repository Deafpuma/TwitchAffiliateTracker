import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AppInitializer {
  static Future<void> initialize() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          name: "twitchTrackerApp",
          options: DefaultFirebaseOptions.currentPlatform,
        );
        print("✅ Firebase initialized successfully.");
      } else {
        print("⚠️ Firebase already initialized. Skipping.");
      }
    } catch (e) {
      print("🔥 Firebase initialization failed: $e");
    }
  }
}
