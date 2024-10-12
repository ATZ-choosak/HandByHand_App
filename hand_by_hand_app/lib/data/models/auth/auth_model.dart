class AuthModel {
  final String accressToken;
  final String tokenType;
  final bool isFirstLogin;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accressToken: json['access_token'],
      tokenType: json['token_type'],
      isFirstLogin: json['is_first_login'],
    );
  }

  AuthModel(
      {required this.accressToken,
      required this.tokenType,
      required this.isFirstLogin});
}
