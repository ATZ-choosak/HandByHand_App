import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/api/api_endpoints.dart';
import 'package:hand_by_hand_app/api/dio_service.dart';
import 'package:hand_by_hand_app/api/user/user_response.dart';
import 'package:hand_by_hand_app/singleton/api_instance.dart';

class UserService {
  Dio api = apiLocal<DioService>().dio;

  Future<UserResponse> getMe() async {
    try {
      final result = await api.get(ApiEndpoints.getMe);
      return UserResponse.fromJson(result.data);
    } on DioException catch (_) {
      return UserResponse("", "", 0);
    } catch (e) {
      return UserResponse("", "", 0);
    }
  }
}
