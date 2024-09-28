import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/data/source/token_service.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';

class AuthRepositoryImpl extends AuthRepository {
  final DioClient dioClient;

  AuthRepositoryImpl({required this.dioClient});

  @override
  Future<Either> login(LoginEvent loginReq) async {
    try {
      final response =
          await dioClient.dio.post(ApiEndpoints.login, data: loginReq.toMap());

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "เข้าสู่ระบบสำเร็จ";
        await TokenService.saveAccessToken(response.data["access_token"]);
        return Right(message);
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
      final message = e.response?.data["message"] ?? "เข้าสู่ระบบไม่สำเร็จ";
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
      final response = await dioClient.dio.post(ApiEndpoints.resetPassword,
          queryParameters: resetPasswordReq.toMap());
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
}
