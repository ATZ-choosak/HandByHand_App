import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/models/auth/auth_model.dart';
import 'package:hand_by_hand_app/data/models/user/user_model.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/data/source/token_service.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:hand_by_hand_app/module/get_location.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';

class AuthRepositoryImpl extends AuthRepository {
  final DioClient dioClient;

  AuthRepositoryImpl({required this.dioClient});

  @override
  Future<Either<String, AuthModel>> login(LoginEvent loginReq) async {
    try {
      final response =
          await dioClient.dio.post(ApiEndpoints.login, data: loginReq.toMap());

      if (response.statusCode == 200) {
        final dynamic auth = response.data;
        AuthModel authModel = AuthModel.fromJson(auth);
        await TokenService.saveAccessToken(authModel.accressToken);
        
        return Right(authModel);
      } else {
        return const Left("เข้าสู่ระบบไม่สำเร็จ");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return const Left("EMAIL_NOT_VERIFY");
      }

      final message = e.response?.data["message"] ?? "เข้าสู่ไม่ระบบสำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> logout() async {
    try {
      await TokenService.deleteAccessToken();
      return const Right("Logout Success");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> register(RegisterEvent registerReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.register, data: registerReq.toMap());

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "สมัครสำเร็จ";
        return Right(message);
      } else {
        final message = response.data["message"] ?? "สมัครไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "สมัครไม่สำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> resendVerifyEmail(ResentVerifyEvent resendVerifyReq) async {
    try {
      final response = await dioClient.dio.post(ApiEndpoints.resentVerifyEmail,
          queryParameters: resendVerifyReq.toMap());
      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "ส่งลิงค์ไปยังอีเมลแล้ว";
        return Right(message);
      } else {
        final message = response.data["message"] ?? "ส่งไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ส่งไม่สำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> resetPassword(ResetPasswordEvent resetPasswordReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.resetPassword, data: resetPasswordReq.toMap());
      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "ส่งลิงค์ไปยังอีเมลแล้ว";
        return Right(message);
      } else {
        final message = response.data["message"] ?? "รีเซ็ตรหัสผ่านไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "รีเซ็ตรหัสผ่านไม่สำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> updateMe(
      UpdateProfileEvent updateProfileReq, File? profileImage) async {
    try {
      FormData updateData;
      LocationModel location = await getCurrentLocation();

      if (profileImage != null) {
        updateData = FormData.fromMap({
          ...updateProfileReq.toMap(),
          "profile_image": await MultipartFile.fromFile(profileImage.path),
          "lon": location.lon,
          "lat": location.lat
        });
      } else {
        updateData = FormData.fromMap({
          ...updateProfileReq.toMap(),
          "lon": location.lon,
          "lat": location.lat
        });
      }

      final response =
          await dioClient.dio.put(ApiEndpoints.updateMe, data: updateData);

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "อัพเดทโปรไฟล์สำเร็จ";
        return Right(message);
      } else {
        final message = response.data["message"] ?? "อัพเดทโปรไฟล์ไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "อัพเดทโปรไฟล์ไม่สำเร็จ";

      return Left(message);
    }
  }

  @override
  Future<Either<String, UserGetMe>> getMe() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.getMe);
      if (response.statusCode == 200) {
        final dynamic data = response.data;
        final userData = UserGetMe.fromJson(data);

        return Right(userData);
      } else {
        final message = response.data["message"] ?? "ไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ไม่สำเร็จ";
      return Left(message);
    }
  }
}
