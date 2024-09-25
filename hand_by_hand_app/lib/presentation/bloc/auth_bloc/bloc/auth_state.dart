part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final String message;

  AuthLoginSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLogoutSuccess extends AuthState {}

class AuthRegisterSuccess extends AuthState {
  final String message;
  final String email;
  AuthRegisterSuccess(this.message, this.email);

  @override
  List<Object?> get props => [message];
}

class AuthResetPasswordSuccess extends AuthState {
  final String message;

  AuthResetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthResentVerifySuccess extends AuthState {
  final String message;

  AuthResentVerifySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthEmailNotVerify extends AuthState {
  final String email;
  AuthEmailNotVerify(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthFirstLogin extends AuthState {}

class AuthUpdateProfileImageLoading extends AuthState {}

class AuthUpdateProfileImageSuccess extends AuthState {
  final File image;

  AuthUpdateProfileImageSuccess({required this.image});
}
