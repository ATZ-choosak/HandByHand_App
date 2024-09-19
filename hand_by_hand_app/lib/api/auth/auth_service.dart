// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/api/api_endpoints.dart';
import 'package:hand_by_hand_app/api/dio_service.dart';
import 'package:hand_by_hand_app/api/auth/auth_response.dart';
import 'package:hand_by_hand_app/api/token_service.dart';
import 'package:hand_by_hand_app/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/singleton/api_instance.dart';

class AuthService {
  Dio api = apiLocal<DioService>().dio;

  Future<AuthResponse> login(LoginEvent data) async {
    try {
      final result = await api.post(ApiEndpoints.login, data: data.toMap());

      if (result.statusCode == 200) {
        await TokenService.saveAccessToken(result.data['access_token']);
        return AuthResponse.response(result.statusCode, result.data["detail"]);
      }

      return AuthResponse.response(result.statusCode, result.data["detail"]);
    } on DioException catch (e) {
      return AuthResponse.response(
          e.response?.statusCode, e.response?.data["detail"]);
    }
  }

  Future<AuthResponse> register(RegisterEvent data) async {
    try {
      final result = await api.post(ApiEndpoints.register, data: data.toMap());

      return AuthResponse.response(result.statusCode, result.data["detail"]);
    } on DioException catch (e) {
      return AuthResponse.response(
          e.response?.statusCode, e.response?.data["detail"]);
    }
  }

  Future<void> logout() async {
    try {
      await TokenService.deleteAccessToken();
    } catch (e) {
      print(e);
    }
  }

  Future<AuthResponse> resetPassword(ResetPasswordEvent data) async {
    try {
      final result = await api.post(ApiEndpoints.resetPassword,
          queryParameters: data.toMap());

      return AuthResponse.response(result.statusCode, result.data["message"]);
    } on DioException catch (e) {
      return AuthResponse.response(
          e.response?.statusCode, e.response?.data["message"]);
    }
  }

  Future<AuthResponse> resendVerifyEmail(ResentVerifyEvent data) async {
    try {
      final result = await api.post(ApiEndpoints.resentVerifyEmail,
          queryParameters: data.toMap());

      return AuthResponse.response(result.statusCode, result.data["message"]);
    } on DioException catch (e) {
      return AuthResponse.response(
          e.response?.statusCode, e.response?.data["message"]);
    }
  }
}
