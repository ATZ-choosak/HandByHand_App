part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

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
