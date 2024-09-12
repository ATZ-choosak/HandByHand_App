class AuthResponse {
  final bool status;
  final String message;
  final int statusCode;

  AuthResponse(this.status, this.message, this.statusCode);

  static AuthResponse response(int? statusCode, String? message) {
    final status = statusCode == 200;
    if (status) {
      return AuthResponse(status, message ?? "Success", statusCode ?? 0);
    }
    return AuthResponse(status, message ?? "เกิดข้อผิดพลาด", statusCode ?? 0);
  }

  static AuthResponse anyResponse() {
    return AuthResponse(false, "เกิดข้อผิดพลาด", 0);
  }
}
