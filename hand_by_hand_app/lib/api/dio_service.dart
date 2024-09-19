// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/api/api_endpoints.dart';
import 'package:hand_by_hand_app/api/token_service.dart';

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
}
