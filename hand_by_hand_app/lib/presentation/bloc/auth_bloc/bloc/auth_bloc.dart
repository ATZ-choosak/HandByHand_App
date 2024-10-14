import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hand_by_hand_app/data/models/auth/auth_model.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final ImagePicker picker = ImagePicker();
  File? profileImage;

  UserGetMe me = UserGetMe(
      email: "",
      phone: "",
      address: "",
      lon: 0,
      lat: 0,
      profileImage: ProfileImage(id: "", url: ""),
      id: 0,
      name: "",
      isVerified: false,
      isFirstLogin: false,
      createdAt: DateTime(2),
      updatedAt: DateTime(2),
      postCount: 0,
      exchangeCompleteCount: 0,
      rating: 0);

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_handleLoginEvent);
    on<RegisterEvent>(_handleRegisterEvent);
    on<ResetPasswordEvent>(_handleResetPasswordEvent);
    on<ResentVerifyEvent>(_handleResentVerifyEvent);
    on<InitEvent>(_handleInitialEvent);
    on<LogoutEvent>(_handleLogoutEvent);
    on<UpdateProfileImageEvent>(_handleUpdateProfileImageEvent);
    on<UpdateProfileEvent>(_handleUpdateProfileEvent);
    on<GetMeEvent>(_handleGetMeEvent);
  }

  Future<void> _handleInitialEvent(
      InitEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
  }

  Future<void> _handleGetMeEvent(
      GetMeEvent event, Emitter<AuthState> emit) async {
    emit(GetMeLoading());
    final result = await authRepository.getMe();

    result.fold((failure) => emit(GetMeFailure(failure)), (success) {
      me = success;
      emit(GetMeSuccess(getMe: success));
    });
  }

  Future<void> _handleUpdateProfileImageEvent(
      UpdateProfileImageEvent event, Emitter<AuthState> emit) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    emit(AuthUpdateProfileImageLoading());
    profileImage = File(image.path);
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
        emit(AuthLoginFailure(failure));
      }
    }, (success) {
      emit(AuthLoginSuccess(success));
    });
  }

  Future<void> _handleRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.register(event);

    result.fold((failure) => emit(AUthRegisterFailure(failure)),
        (success) => emit(AuthRegisterSuccess(success, event.email)));
  }

  Future<void> _handleResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.resetPassword(event);

    result.fold((failure) => emit(AuthResetPasswordFailure(failure)),
        (success) => emit(AuthResetPasswordSuccess(success)));
  }

  Future<void> _handleResentVerifyEvent(
      ResentVerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.resendVerifyEmail(event);

    result.fold((failure) => emit(AuthResendVerifyFailure(failure)),
        (success) => emit(AuthResentVerifySuccess(success)));
  }

  Future<void> _handleUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthUpdateProfileLoading());
    final result = await authRepository.updateMe(event, profileImage);
    result.fold((failure) => emit(AuthUpdateProfileFailure(failure)),
        (success) => emit(AuthUpdateProfileSuccess()));
  }
}
