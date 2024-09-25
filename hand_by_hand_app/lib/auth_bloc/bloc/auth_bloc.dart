import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hand_by_hand_app/api/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService auth;
  final ImagePicker picker = ImagePicker();

  AuthBloc({required this.auth}) : super(AuthInitial()) {
    on<LoginEvent>(_handleLoginEvent);
    on<RegisterEvent>(_handleRegisterEvent);
    on<ResetPasswordEvent>(_handleResetPasswordEvent);
    on<ResentVerifyEvent>(_handleResentVerifyEvent);
    on<InitEvent>(_handleInitialEvent);
    on<LogoutEvent>(_handleLogoutEvent);
    on<UpdateProfileImageEvent>(_handleUpdateProfileImageEvent);
  }

  Future<void> _handleInitialEvent(
      InitEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
  }

  Future<void> _handleUpdateProfileImageEvent(
      UpdateProfileImageEvent event, Emitter<AuthState> emit) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    emit(AuthUpdateProfileImageLoading());
    emit(AuthUpdateProfileImageSuccess(image: File(image.path)));
    
  }

  Future<void> _handleLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await auth.logout();
    emit(AuthLogoutSuccess());
  }

  Future<void> _handleLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await auth.login(event);

    if (result.status) {
      //emit(AuthLoginSuccess(result.message));
      //mockup first login
      emit(AuthFirstLogin());
    } else {
      if (result.statusCode == 400) {
        emit(AuthEmailNotVerify(
            result.message, result.statusCode, event.username));
      } else {
        emit(AuthFailure(result.message, result.statusCode));
      }
    }
  }

  Future<void> _handleRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await auth.register(event);
    if (result.status) {
      emit(AuthRegisterSuccess(result.message, event.email));
    } else {
      emit(AuthFailure(result.message, result.statusCode));
    }
  }

  Future<void> _handleResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await auth.resetPassword(event);
    if (result.status) {
      emit(AuthResetPasswordSuccess(result.message));
    } else {
      emit(AuthFailure(result.message, result.statusCode));
    }
  }

  Future<void> _handleResentVerifyEvent(
      ResentVerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await auth.resendVerifyEmail(event);
    if (result.status) {
      emit(AuthResentVerifySuccess(result.message));
    } else {
      emit(AuthFailure(result.message, result.statusCode));
    }
  }
}
