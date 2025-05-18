import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:operatortracker/core/services/websocket_service.dart';
import 'package:operatortracker/core/session/storage_manager.dart';
import 'package:operatortracker/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';
import 'package:operatortracker/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/listen_chat_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:operatortracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:operatortracker/features/login/data/datasources/login_remote_datasource.dart';
import 'package:operatortracker/features/login/data/repositories/login_repository_impl.dart';
import 'package:operatortracker/features/login/domain/repositories/login_repository.dart';
import 'package:operatortracker/features/login/domain/usecases/login_usecase.dart';
import 'package:operatortracker/features/login/presentation/bloc/login_bloc.dart';
import '../../features/registrationdevice/data/datasources/installation_remote_datasource.dart';
import '../../features/registrationdevice/data/repositories/installation_repository_impl.dart';
import '../../features/registrationdevice/domain/repositories/installation_repository.dart';
import '../../features/registrationdevice/domain/usecases/check_device_usecase.dart';
import '../../features/registrationdevice/domain/usecases/register_device_usecase.dart';
import '../../features/registrationdevice/presentation/bloc/installation_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Installation
  sl.registerFactory(
    () => InstallationBloc(checkDevice: sl(), registerDevice: sl()),
  );
  sl.registerLazySingleton(() => CheckDeviceUseCase(sl()));
  sl.registerLazySingleton(() => RegisterDeviceUseCase(sl()));
  sl.registerLazySingleton<InstallationRepository>(
    () => InstallationRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<InstallationRemoteDataSource>(
    () => InstallationRemoteDataSourceImpl(client: sl()),
  );


  // Login Feature
  sl.registerFactory(() => LoginBloc(loginUseCase: sl(), storage: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl()),
  );

  // Home Feature
  sl.registerFactory(() => HomeBloc(webSocketService: sl(), storageManager: sl()));

  // Chat Feature
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetChatMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SendChatMessageUseCase(sl()));
  sl.registerLazySingleton(() => ListenChatMessagesUseCase(sl()));
  sl.registerFactory(
    () => ChatBloc(
      getMessages: sl(),
      sendMessage: sl(),
      listenMessages: sl(),
      storageManager: sl(),
    ),
  );

  // Core
  // sl.registerLazySingleton(() => SessionManager());
  sl.registerLazySingleton(() => StorageManager());
  sl.registerLazySingleton<WebSocketService>(() => WebSocketService());
  sl.registerLazySingleton(() => http.Client());
}
