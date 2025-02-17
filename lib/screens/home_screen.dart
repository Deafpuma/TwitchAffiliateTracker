import 'package:flutter/material.dart';
import 'analytics_screen.dart';
import 'community_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("View Analytics"),
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AnalyticsScreen()),
            ),
          ),
          ElevatedButton(
            child: Text("Community"),
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => CommunityScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
