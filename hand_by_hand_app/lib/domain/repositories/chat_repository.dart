import 'package:dartz/dartz.dart';
import 'package:hand_by_hand_app/presentation/bloc/chat_bloc/bloc/chat_bloc.dart';

abstract class ChatRepository {
  Future<Either> getChatSessions();
  Future<Either> createChatSession(CreateChatSessionEvent createChatSessionReq);
  Future<Either> getMessage(GetMessageEvent getMessageReq);
  Future<Either> sendMessage(SendMessageInputEvent sendMessageReq);
}
