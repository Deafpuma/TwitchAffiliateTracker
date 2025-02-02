import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> logEvent(String eventName, Map<String, Object>? parameters) async {
    await analytics.logEvent(name: eventName, parameters: parameters);
  }

  static Future<void> logLogin(String loginMethod) async {
    await analytics.logLogin(loginMethod: loginMethod);
  }

  static Future<void> logSubscription(bool isSubscribed) async {
    await analytics.logEvent(name: "subscription_status", parameters: {"subscribed": isSubscribed});
  }
}
