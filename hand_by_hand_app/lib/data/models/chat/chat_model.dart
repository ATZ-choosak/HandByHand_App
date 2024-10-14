import 'package:hand_by_hand_app/data/models/user/user_model.dart';

class ChatSession {
  final String id;
  final User user;

  ChatSession({
    required this.id,
    required this.user,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['_id'] as String,
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final ProfileImage profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: ProfileImage.fromJson(json['profile_image']),
    );
  }
}


class CreateChatSessionResponse {

  final String message;
  final String chatId;

  CreateChatSessionResponse({required this.message, required this.chatId});

  factory CreateChatSessionResponse.fromJson(Map<String, dynamic> json) {
    return CreateChatSessionResponse(
      message: json['message'],
      chatId: json['chat_id'],
    );
  }

}


class ChatMessage {
  final Receiver sender;
  final Receiver receiver;
  final String message;
  final DateTime timestamp;
  final String messageType;
  final bool senderIsMe;
  final bool receiverIsMe;

  ChatMessage({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.timestamp,
    required this.messageType,
    required this.senderIsMe,
    required this.receiverIsMe,
  });

  // Add fromJson
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      sender: Receiver.fromJson(json['sender']),
      receiver: Receiver.fromJson(json['receiver']),
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      messageType: json['message_type'],
      senderIsMe: json['sender_is_me'],
      receiverIsMe: json['receiver_is_me'],
    );
  }
}

class Receiver {
  final int id;
  final String name;
  final String email;
  final ProfileImage profileImage;

  Receiver({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  // Add fromJson
  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: ProfileImage.fromJson(json['profile_image']),
    );
  }
}

