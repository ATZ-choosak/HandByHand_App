import 'package:hand_by_hand_app/config/config.dart';

class ApiEndpoints {
  static String baseUrl = Config.baseUrl;

  //Endpoint
  static String login = "$baseUrl/auth/login";
  static String register = "$baseUrl/auth/register";
  static String resetPassword = "$baseUrl/auth/password-reset/request";
  static String resentVerifyEmail = "$baseUrl/auth/resend-verification";
  static String getMe = "$baseUrl/users/me";
}