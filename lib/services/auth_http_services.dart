import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../key/api_key.dart';

class AuthHttpServices {
  // web api key
  final String _apiKey = ApiKey.apiKey;

  // authenticate
  Future<void> _authenticate(
    String email,
    String password,
    String query,
  ) async {
    Uri url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:$query?key=$_apiKey",
    );

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString("token", data['idToken']);
      await sharedPreferences.setString("userId", data['localId']);
      DateTime expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            data['expiresIn'],
          ),
        ),
      );
      await sharedPreferences.setString("expiryDate", expiryDate.toString());
    } catch (e) {
      rethrow;
    }
  }

  // register
  Future<void> register(String email, String password) async {
    await _authenticate(email, password, "signUp");
  }

  // login
  Future<void> login(String email, String password) async {
    await _authenticate(email, password, "signInWithPassword");
  }

  // reset password
  Future<void> resetPassword(String email) async {
    Uri url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey",
    );

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "requestType": "PASSWORD_RESET",
            "email": email,
          },
        ),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  // check auth
  Future<bool> checkAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    if (token == null) {
      return false;
    }

    DateTime expiryDate =
        DateTime.parse(sharedPreferences.getString("expiryDate")!);

    // check token expiration date
    return expiryDate.isAfter(DateTime.now());
  }

  // logout
  static void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
