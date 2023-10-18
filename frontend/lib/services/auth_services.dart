import 'dart:convert';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String apiUrl = 'http://127.0.0.1:3333';
  String endpoint = 'auth';

  Future<Auth?> store(String username, String password) async {
    final uri = Uri.parse('$apiUrl/$endpoint');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final body = json.encode({
      'username': username,
      'password': password,
    });

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final authData = await json.decode(response.body);
      final auth = Auth.fromJson(authData);
      await storeToken(auth);
      return auth;
    } else {
      return null;
    }
  }

  Future<void> destroy() async {
    var token = await getToken("token");

    final uri = Uri.parse('$apiUrl/$endpoint');

    final headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    final response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      deleteToken("token");
    } else {
      throw Exception('Falha no logout');
    }
  }
}
