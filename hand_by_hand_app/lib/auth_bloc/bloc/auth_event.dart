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
    return <String, dynamic>{"username": username, "password": password};
  }

  @override
  List<Object> get props => [username, password];
}

class LogoutEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;

  RegisterEvent(this.email, this.name, this.password);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "name": name,
      "password": password
    };
  }

  @override
  List<Object> get props => [email, name, password];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  ResetPasswordEvent(this.email);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
    };
  }

  @override
  List<Object> get props => [email];
}

class ResentVerifyEvent extends AuthEvent {
  final String email;

  ResentVerifyEvent(this.email);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
    };
  }

  @override
  List<Object> get props => [email];
}
