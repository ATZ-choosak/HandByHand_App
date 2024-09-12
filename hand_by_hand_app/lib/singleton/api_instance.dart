import 'package:get_it/get_it.dart';
import 'package:hand_by_hand_app/api/dio_service.dart';

final apiLocal = GetIt.instance;

void setupLocaltor() {
  apiLocal.registerSingleton<DioService>(DioService());
}
