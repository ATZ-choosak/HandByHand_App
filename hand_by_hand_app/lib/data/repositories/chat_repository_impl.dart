import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/models/chat/chat_model.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/domain/repositories/chat_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/chat_bloc/bloc/chat_bloc.dart';

class ChatRepositoryImpl extends ChatRepository {
  final DioClient dioClient;

  ChatRepositoryImpl({required this.dioClient});

  @override
  Future<Either> getChatSessions() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.getChatSessions);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final chatSessions =
            data.map((json) => ChatSession.fromJson(json)).toList();

        return Right(chatSessions);
      } else {
        final message = response.data["message"] ?? "ไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ไม่สำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> createChatSession(
      CreateChatSessionEvent createChatSessionReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.createChat, data: createChatSessionReq.toMap());

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        final chat = CreateChatSessionResponse.fromJson(data);

        return Right(chat);
      } else {
        final message = response.data["message"] ?? "ไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ไม่สำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> getMessage(GetMessageEvent getMessageReq) async {
    try {
      final response = await dioClient.dio
          .get(ApiEndpoints.getMessage(getMessageReq.chatId));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final message = data
            .map(
              (e) => ChatMessage.fromJson(e),
            )
            .toList();

        return Right(message);
      } else {
        final message = response.data["message"] ?? "ไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ไม่สำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> sendMessage(SendMessageInputEvent sendMessageReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.sendMessage, data: sendMessageReq.toMap());

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "ยอมรับสำเร็จ";

        return Right(message);
      } else {
        final message = response.data["message"] ?? "ยอมรับไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ยอมรับไม่สำเร็จ";

      return Left(message);
    }
  }
}
