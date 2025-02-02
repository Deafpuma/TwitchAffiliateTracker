import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  static Future<InitializationStatus> initialize() {
    return MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd(String adUnitId) {
    return BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
      ),
    );
  }
}
