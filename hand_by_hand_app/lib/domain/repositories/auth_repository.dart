import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hand_by_hand_app/data/models/auth/auth_model.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';

abstract class AuthRepository {
  Future<Either<String, AuthModel>> login(LoginEvent loginReq);
  Future<Either> register(RegisterEvent registerReq);
  Future<Either> logout();
  Future<Either> resetPassword(ResetPasswordEvent resetPasswordReq);
  Future<Either> resendVerifyEmail(ResentVerifyEvent resendVerifyReq);
  Future<Either<String, UserGetMe>> getMe();
  Future<Either> updateMe(
      UpdateProfileEvent updateProfileReq, File? profileImage);
}
