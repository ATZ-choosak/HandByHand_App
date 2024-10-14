import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/data/models/chat/chat_model.dart';
import 'package:hand_by_hand_app/domain/repositories/chat_repository.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<GetChatSessionsEvent>(_handleGetChatSessionsEvent);
    on<CreateChatSessionEvent>(_handleCreateChatSessionEvent);
    on<GetMessageEvent>(_handleGetMessageEvent);
    on<SendMessageInputEvent>(_handleSendMessageInputEvent);
  }

  Future<void> _handleGetChatSessionsEvent(
      GetChatSessionsEvent event, Emitter<ChatState> emit) async {
    emit(GetChatSessionsLoading());
    final result = await chatRepository.getChatSessions();

    result.fold((failure) => emit(GetChatSessionsFailure(failure)), (success) {
      emit(GetChatSessionsSuccess(sessions: success));
    });
  }

  Future<void> _handleCreateChatSessionEvent(
      CreateChatSessionEvent event, Emitter<ChatState> emit) async {
    emit(CreateChatSessionsLoading());
    final result = await chatRepository.createChatSession(event);

    result.fold((failure) => emit(CreateChatSessionsFailure(failure)),
        (success) {
      emit(CreateChatSessionsSuccess(response: success));
    });
  }

  Future<void> _handleGetMessageEvent(
      GetMessageEvent event, Emitter<ChatState> emit) async {
    emit(GetMessageLoading());
    final result = await chatRepository.getMessage(event);

    result.fold((failure) => emit(GetMessageFailure(failure)), (success) {
      emit(GetMessageSuccess(messages: success));
    });
  }

  Future<void> _handleSendMessageInputEvent(
      SendMessageInputEvent event, Emitter<ChatState> emit) async {
    emit(SendMessageLoading());
    final result = await chatRepository.sendMessage(event);

    result.fold((failure) => emit(SendMessageFailure(failure)), (success) {
      emit(SendMessageSuccess(message: success));
    });
  }
}
