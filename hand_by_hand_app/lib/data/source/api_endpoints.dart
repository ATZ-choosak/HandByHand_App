import 'package:hand_by_hand_app/config/config.dart';

class ApiEndpoints {
  static String baseUrl = Config.baseUrl;

  //Endpoint

  //auth
  static String login = "$baseUrl/auth/login";
  static String register = "$baseUrl/auth/register";
  static String resetPassword = "$baseUrl/auth/password-reset/request";
  static String resentVerifyEmail = "$baseUrl/auth/resend-verification";
  static String getMe = "$baseUrl/users/me";
  static String updateMe = "$baseUrl/users/me";

  //category
  static String getCategories = "$baseUrl/categorys/categories";
  static String categoryInteresting = "$baseUrl/customerInterest/customer-interest";

  //item
  static String item = "$baseUrl/items/";
  static String myItem = "$baseUrl/items/my-items";

  static String updateItem(int id){
    return "$baseUrl/items/items/$id";
  }

  static String deleteItem(int id) {
    return "$baseUrl/items/$id";
  }

}