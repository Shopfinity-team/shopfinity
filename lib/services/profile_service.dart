import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfileService {
  
  Future<Map<String, dynamic>> getCurrentUser(String token) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

}