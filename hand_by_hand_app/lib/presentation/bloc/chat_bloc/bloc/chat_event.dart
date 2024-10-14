part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetChatSessionsEvent extends ChatEvent {}

class CreateChatSessionEvent extends ChatEvent {
  final int userId;

  CreateChatSessionEvent({required this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "user": userId,
    };
  }
}

class GetMessageEvent extends ChatEvent {
  final String chatId;

  GetMessageEvent({required this.chatId});
}

class SendMessageInputEvent extends ChatEvent {
  final String chatId;
  final String message;

  SendMessageInputEvent({
    required this.chatId,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "chat_id": chatId,
      "message": message,
      "message_type": "text"
    };
  }
}
