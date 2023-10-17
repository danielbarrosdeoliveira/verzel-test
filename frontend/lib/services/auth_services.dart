import 'dart:convert';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl;
  String endpoint = 'auth';

  AuthService(this.apiUrl);

  Future<Auth> store(User user) async {
    final uri = Uri.parse('$apiUrl/$endpoint');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final body = json.encode({
      'username': user.username,
      'password': user.password,
    });

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final authData = json.decode(response.body);
      final auth = Auth.fromJson(authData);
      return auth;
    } else {
      throw Exception('Falha na solicitação');
    }
  }

  Future<void> destroy(String token) async {
    final uri = Uri.parse('$apiUrl/$endpoint');

    final headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    final response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
    } else {
      throw Exception('Falha no logout');
    }
  }
}
