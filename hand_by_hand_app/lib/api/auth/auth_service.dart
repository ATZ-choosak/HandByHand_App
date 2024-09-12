// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/api/api_endpoints.dart';
import 'package:hand_by_hand_app/api/dio_service.dart';
import 'package:hand_by_hand_app/api/auth/auth_response.dart';
import 'package:hand_by_hand_app/api/token_service.dart';
import 'package:hand_by_hand_app/singleton/api_instance.dart';

class AuthService {
  Dio api = apiLocal<DioService>().dio;

  Future<AuthResponse> login(String username, String password) async {
    try {
      final result = await api.post(ApiEndpoints.login,
          data: {'username': username, 'password': password});

      if (result.statusCode == 200) {
        await TokenService.saveAccessToken(result.data['access_token']);
        return AuthResponse.response(result.statusCode, result.data["detail"]);
      }

      return AuthResponse.response(result.statusCode, result.data["detail"]);
    } on DioException catch (e) {
      return AuthResponse.response(
          e.response?.statusCode, e.response?.data["detail"] ?? "");
    } catch (e) {
      return AuthResponse.anyResponse();
    }
  }

  Future<AuthResponse> register(
      String email, String name, String password) async {
    try {
      final result = await api.post(ApiEndpoints.register,
          data: {'email': email, 'name': name, 'password': password});

      return AuthResponse.response(result.statusCode, result.data["detail"]);
    } on DioException catch (e) {
      return AuthResponse.response(
          e.response?.statusCode, e.response?.data["detail"]);
    } catch (e) {
      return AuthResponse.anyResponse();
    }
  }

  Future<void> logout() async {
    try {
      await TokenService.deleteAccessToken();
    } catch (e) {
      print(e);
    }
  }
}
