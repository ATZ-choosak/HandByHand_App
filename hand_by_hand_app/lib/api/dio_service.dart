// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/api/api_endpoints.dart';
import 'package:hand_by_hand_app/api/auth/auth_service.dart';
import 'package:hand_by_hand_app/api/auth/auth_response.dart';
import 'package:hand_by_hand_app/api/token_service.dart';
import 'package:hand_by_hand_app/api/user/user_response.dart';
import 'package:hand_by_hand_app/api/user/user_service.dart';

class DioService {
  late Dio dio;

  DioService() {
    dio = Dio(BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'}));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenService.getAccessToken();

        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        handler.next(error);
      },
    ));
  }

  Future<AuthResponse> login(String username, String password) async {
    return AuthService().login(username, password);
  }

  Future<AuthResponse> register(String email, String name, String password) async {
    return AuthService().register(email, name, password);
  }

  Future<void> logout() async {
    return AuthService().logout();
  }

  Future<UserResponse> getMe() async {
    return UserService().getMe();
  }
}
