import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hand_by_hand_app/config/config.dart';
import 'package:hand_by_hand_app/data/repositories/auth_repository_impl.dart';
import 'package:hand_by_hand_app/data/repositories/category_repository_impl.dart';
import 'package:hand_by_hand_app/data/repositories/chat_repository_impl.dart';
import 'package:hand_by_hand_app/data/repositories/exchage_repository_impl.dart';
import 'package:hand_by_hand_app/data/repositories/item_repository_impl.dart';
import 'package:hand_by_hand_app/data/repositories/my_item_repository_impl.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/data/source/location_service.dart';
import 'package:hand_by_hand_app/data/source/socket_service.dart';
import 'package:hand_by_hand_app/data/source/token_service.dart';
import 'package:hand_by_hand_app/domain/repositories/auth_repository.dart';
import 'package:hand_by_hand_app/domain/repositories/category_repository.dart';
import 'package:hand_by_hand_app/domain/repositories/chat_repository.dart';
import 'package:hand_by_hand_app/domain/repositories/exchange_repository.dart';
import 'package:hand_by_hand_app/domain/repositories/item_repository.dart';
import 'package:hand_by_hand_app/domain/repositories/my_item_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/exchange_bloc/bloc/exchange_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/my_item_bloc/bloc/my_item_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  //Register ItemRepository implementation
  getIt.registerLazySingleton<ItemRepository>(
      () => ItemRepositoryImpl(dioClient: getIt<DioClient>()));

  //register ItemBloc
  getIt.registerFactory<ItemBloc>(() => ItemBloc(
      categoryRepository: getIt<CategoryRepository>(),
      itemRepository: getIt<ItemRepository>()));

  //Register MyItemRepository implementation
  getIt.registerLazySingleton<MyItemRepository>(
      () => MyItemRepositoryImpl(dioClient: getIt<DioClient>()));

  //register MyItemBloc
  getIt.registerFactory<MyItemBloc>(
      () => MyItemBloc(myItemRepository: getIt<MyItemRepository>()));

  //Register ExchangeRepository implementation
  getIt.registerLazySingleton<ExchangeRepository>(
      () => ExchageRepositoryImpl(dioClient: getIt<DioClient>()));

  //register ExchangeBloc
  getIt.registerFactory<ExchangeBloc>(
      () => ExchangeBloc(exchageRepository: getIt<ExchangeRepository>()));

  //Register ChatRepository implementation
  getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(dioClient: getIt<DioClient>()));

  //register ChatBloc
  getIt.registerFactory<ChatBloc>(
      () => ChatBloc(chatRepository: getIt<ChatRepository>()));

  //Register LocationService as a singleton
  getIt.registerLazySingleton(() => LocationService());

  getIt.registerSingleton<IO.Socket>(
    IO.io(Config.socketUrl, <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    }),
  );

  // Register the SocketService
  getIt.registerSingleton<SocketService>(SocketService());
}
