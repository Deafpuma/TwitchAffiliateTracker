import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ads_service.dart';

class AppInitializer {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
    await AdsService.initialize();
  }
}
