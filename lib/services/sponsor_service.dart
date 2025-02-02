import 'package:cloud_firestore/cloud_firestore.dart';

class SponsorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSponsor(String sponsorName, String offerDetails, String link) async {
    await _db.collection('sponsors').add({
      'sponsorName': sponsorName,
      'offerDetails': offerDetails,
      'link': link,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSponsors() {
    return _db.collection('sponsors').orderBy('timestamp', descending: true).snapshots();
  }
}
