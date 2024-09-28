import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final ImagePicker picker = ImagePicker();

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
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
    final result = await authRepository.logout();

    result.fold((failure) => AuthFailure(failure),
        (success) => emit(AuthLogoutSuccess()));
  }

  Future<void> _handleLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await authRepository.login(event);

    result.fold((failure) {
      if (failure == "EMAIL_NOT_VERIFY") {
        emit(AuthEmailNotVerify(event.username));
      } else {
        emit(AuthFailure(failure));
      }
    }, (success) => emit(AuthFirstLogin()));
  }

  Future<void> _handleRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.register(event);

    result.fold((failure) => emit(AuthFailure(failure)),
        (success) => emit(AuthRegisterSuccess(success, event.email)));
  }

  Future<void> _handleResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.resetPassword(event);

    result.fold((failure) => emit(AuthFailure(failure)),
        (success) => emit(AuthResetPasswordSuccess(success)));
  }

  Future<void> _handleResentVerifyEvent(
      ResentVerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.resendVerifyEmail(event);

    result.fold((failure) => emit(AuthFailure(failure)),
        (success) => emit(AuthResentVerifySuccess(success)));
  }
}
