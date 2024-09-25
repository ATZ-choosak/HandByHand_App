import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hand_by_hand_app/data/repositories/auth_reposittory_impl.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register Dio Instance
  getIt.registerSingleton<Dio>(Dio());

  // Register DioClient
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));

  //Register AuthRepository implementation
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthReposittoryImpl(dioClient: getIt<DioClient>()));

  //Register AuthBloc
  getIt.registerFactory<AuthBloc>(
      () => AuthBloc(authRepository: getIt<AuthRepository>()));
}
