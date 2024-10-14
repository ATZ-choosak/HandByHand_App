part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class GetChatSessionsLoading extends ChatState {}

class GetChatSessionsFailure extends ChatState {
  final String message;

  GetChatSessionsFailure(this.message);
}

class GetChatSessionsSuccess extends ChatState {
  final List<ChatSession> sessions;

  GetChatSessionsSuccess({required this.sessions});
}

class CreateChatSessionsLoading extends ChatState {}

class CreateChatSessionsFailure extends ChatState {
  final String message;

  CreateChatSessionsFailure(this.message);
}

class CreateChatSessionsSuccess extends ChatState {
  final CreateChatSessionResponse response;

  CreateChatSessionsSuccess({required this.response});
}

class GetMessageLoading extends ChatState {}

class GetMessageFailure extends ChatState {
  final String message;

  GetMessageFailure(this.message);
}

class GetMessageSuccess extends ChatState {
  final List<ChatMessage> messages;

  GetMessageSuccess({required this.messages});
}

class SendMessageLoading extends ChatState {}

class SendMessageFailure extends ChatState {
  final String message;

  SendMessageFailure(this.message);
}

class SendMessageSuccess extends ChatState {
  final String message;

  SendMessageSuccess({required this.message});
}
