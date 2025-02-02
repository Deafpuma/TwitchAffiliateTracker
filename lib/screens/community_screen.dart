import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _streamers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCommunityData();
  }

  Future<void> _fetchCommunityData() async {
    try {
      // Fetching streamers from Firestore (simulated call, update as necessary)
      setState(() {
        _streamers = [
          {"name": "Streamer1", "shoutouts": 15},
          {"name": "Streamer2", "shoutouts": 10},
          {"name": "Streamer3", "shoutouts": 8},
        ];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print("Error fetching community data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Community Support")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _streamers.length,
        itemBuilder: (context, index) {
          final streamer = _streamers[index];
          return ListTile(
            title: Text(streamer["name"]),
            subtitle: Text("Shoutouts: ${streamer["shoutouts"]}"),
            leading: Icon(Icons.person),
          );
        },
      ),
    );
  }
}