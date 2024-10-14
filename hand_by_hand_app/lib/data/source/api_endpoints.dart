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
  static String categoryInteresting =
      "$baseUrl/customerInterest/customer-interest";

  //item
  static String item = "$baseUrl/items/";
  static String myItem = "$baseUrl/items/my-items";

  static String updateItem(int id) {
    return "$baseUrl/items/items/$id";
  }

  static String deleteItem(int id) {
    return "$baseUrl/items/$id";
  }

  static String getItemById(int id) {
    return "$baseUrl/items/$id";
  }

  //Exchange
  static String checkExchange = "$baseUrl/exchanges/exchange-request";
  static String exchangeRequest = "$baseUrl/exchanges/request";
  static String incoming = "$baseUrl/exchanges/incoming";
  static String outGoing = "$baseUrl/exchanges/outgoing";
  static String exchangeAccept = "$baseUrl/exchanges/accept";
  static String exchangeReject = "$baseUrl/exchanges/reject";
  static String checkUuid = "$baseUrl/exchanges/check-uuid";


  //Chat
  static String getChatSessions = "$baseUrl/chats/sessions";
  static String createChat = "$baseUrl/chats";
  static String sendMessage = "$baseUrl/chats/send_message";
  static String getMessage(String chatId) {
    return "$baseUrl/chats/messages/$chatId";
  }
}
