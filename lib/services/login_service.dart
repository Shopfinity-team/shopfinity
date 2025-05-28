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
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);

      // final address = data['address'];
      // if (address != null) {
      //   await prefs.setString('address', address['address'] ?? '');
      //   await prefs.setString('city', address['city'] ?? '');
      //   await prefs.setString('state', address['state'] ?? '');
      //   await prefs.setString(
      //       'postalCode', address['postalCode'].toString() ?? '');
      // }
      // await prefs.setString('firstName', data['firstName']);
      // await prefs.setString('lastName', data['lastName']);

      await prefs.setString('address', '123 Test Street');
      await prefs.setString('city', 'Galle');
      await prefs.setString('state', 'Southern');
      await prefs.setString('postalCode', '80000');

      return accessToken;
    } else {
      return null;
    }
  }
}
