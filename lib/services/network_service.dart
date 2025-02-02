import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  static Future<Map<String, dynamic>> getRequest(String url, Map<String, String> headers) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
