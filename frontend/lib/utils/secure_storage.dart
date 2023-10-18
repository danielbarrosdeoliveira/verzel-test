import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/auth_model.dart';

Future<void> storeToken(Auth auth) async {
  const storage = FlutterSecureStorage();

  await storage.write(key: "token", value: auth.token);
}

Future<String?> getToken(String key) async {
  const storage = FlutterSecureStorage();

  String? token = await storage.read(key: key);

  if (token == null) {
    return null;
  }

  return token;
}

deleteToken(String key) async {
  const storage = FlutterSecureStorage();

  await storage.delete(key: key);

  var teste = await getToken("token");

  return teste;
}
