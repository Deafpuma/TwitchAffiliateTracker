import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DeeplinkService {
  static Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? dynamicLinkData) {
      final Uri? deepLink = dynamicLinkData?.link;
      if (deepLink != null) {
        _handleDeepLink(deepLink);
      }
    }).onError((error) {
      print('Error handling deep link: $error');
    });
  }

  static void _handleDeepLink(Uri deepLink) {
    print('Navigating to: ${deepLink.toString()}');
    // Add navigation logic based on the deep link
  }
}
