import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';

class AuthReposittoryImpl extends AuthRepository {
  final DioClient dioClient;

  AuthReposittoryImpl({required this.dioClient});

  @override
  Future<Either> login(LoginEvent loginReq) async {
    try {
      final response =
          await dioClient.dio.post(ApiEndpoints.login, data: loginReq.toMap());

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "เข้าสู่ระบบสำเร็จ";
        return Right(message);
      } else if (response.statusCode == 400) {
        return const Right({"email_verify": false});
      } else {
        return const Left("เข้าสู่ระบบไม่สำเร็จ");
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "เข้าสู่ระบบสำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Either> register(RegisterEvent registerReq) {
    throw UnimplementedError();
  }

  @override
  Future<Either> resendVerifyEmail(ResentVerifyEvent resendVerifyReq) {
    throw UnimplementedError();
  }

  @override
  Future<Either> resetPassword(ResetPasswordEvent resetPasswordReq) {
    throw UnimplementedError();
  }
}
