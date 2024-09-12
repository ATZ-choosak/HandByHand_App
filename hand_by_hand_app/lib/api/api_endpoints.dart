import 'package:hand_by_hand_app/config/config.dart';

class ApiEndpoints {
  static String baseUrl = Config.baseUrl;

  //Endpoint
  static String login = "$baseUrl/auth/token";
  static String register = "$baseUrl/auth/register";
  static String getMe = "$baseUrl/users/me";
}