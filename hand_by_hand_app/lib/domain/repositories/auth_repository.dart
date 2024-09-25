import 'package:dartz/dartz.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';

abstract class AuthRepository {

  Future<Either> login(LoginEvent loginReq);
  Future<Either> register(RegisterEvent registerReq);
  Future<Either> logout();
  Future<Either> resetPassword(ResetPasswordEvent resetPasswordReq);
  Future<Either> resendVerifyEmail(ResentVerifyEvent resendVerifyReq);

}