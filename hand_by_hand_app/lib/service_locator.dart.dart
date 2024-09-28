import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hand_by_hand_app/data/repositories/auth_repository_impl.dart';
import 'package:hand_by_hand_app/data/repositories/category_repository_impl.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/data/source/token_service.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:hand_by_hand_app/domain/repositories/category_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/category_bloc/bloc/category_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register Dio Instance
  getIt.registerSingleton<Dio>(Dio());

  //Register Token Service
  getIt.registerSingleton<TokenService>(TokenService());

  // Register DioClient
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));

  //Register AuthRepository implementation
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(dioClient: getIt<DioClient>()));

  //Register CategoryRepository implementation
  getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(dioClient: getIt<DioClient>()));

  //Register AuthBloc
  getIt.registerFactory<AuthBloc>(
      () => AuthBloc(authRepository: getIt<AuthRepository>()));

  //Register CategoryBloc
  getIt.registerFactory<CategoryBloc>(
      () => CategoryBloc(categoryRepository: getIt<CategoryRepository>()));
}
