import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> refreshToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/refresh'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {'refreshToken': refreshToken},
      )
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', newAccessToken);
      await prefs.setString('refresh_token', newRefreshToken);
    } else {
      throw Exception('Failed to refresh token');
    }
  }   
}