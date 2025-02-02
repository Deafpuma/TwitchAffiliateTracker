import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/analytics_screen.dart';
import '../screens/community_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => HomeScreen(),
    '/analytics': (context) => AnalyticsScreen(),
    '/community': (context) => CommunityScreen(),
  };
}
