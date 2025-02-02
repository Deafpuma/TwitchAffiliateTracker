import 'package:flutter/material.dart';
import '../services/twitch_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final TwitchService _twitchService = TwitchService();
  Map<String, dynamic>? _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchTwitchData();
  }

  Future<void> _fetchTwitchData() async {
    try {
      var userData = await _twitchService.getUserData("your_twitch_username");
      setState(() {
        _userData = userData;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print("Error fetching Twitch data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Twitch Analytics")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _userData != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username: ${_userData!["display_name"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Followers: ${_userData!["followers"]}"),
            Text("Total Views: ${_userData!["view_count"]}"),
          ],
        ),
      )
          : Center(child: Text("Failed to load data")),
    );
  }
}
