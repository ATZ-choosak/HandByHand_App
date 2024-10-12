part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "username": username,
      "password": password,
    };
  }

  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "password": password,
    };
  }

  RegisterEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class UpdateProfileImageEvent extends AuthEvent {}

class GetMeEvent extends AuthEvent {}

class UpdateProfileEvent extends AuthEvent {
  final String username;
  final String phone;
  final String address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": username,
      "phone": phone,
      "address": address,
    };
  }

  UpdateProfileEvent({
    required this.username,
    required this.phone,
    required this.address,
  });
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
    };
  }

  ResetPasswordEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ResentVerifyEvent extends AuthEvent {
  final String email;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
    };
  }

  ResentVerifyEvent(this.email);

  @override
  List<Object> get props => [email];
}
