class Auth {
  final String type;
  final String token;
  final DateTime expiresAt;

  Auth({
    required this.type,
    required this.token,
    required this.expiresAt,
  });

  factory Auth.fromJson(Map<String, dynamic> data) {
    return Auth(
      type: data['type'],
      token: data['token'],
      expiresAt: DateTime.parse(data['expires_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'token': token,
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}
