import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("https://dummyjson.com/auth/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['accessToken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);

      return token;
    } else {
      return null;
    }
  }
}
