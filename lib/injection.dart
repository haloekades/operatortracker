import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:operatortracker/core/services/websocket_service.dart';
import 'package:operatortracker/core/session/SessionManager.dart';
import 'package:operatortracker/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:operatortracker/features/chat/domain/repositories/chat_repository.dart';
import 'package:operatortracker/features/chat/domain/usecases/get_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/listen_chat_messages_use_case.dart';
import 'package:operatortracker/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:operatortracker/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:operatortracker/features/login/data/datasources/login_remote_datasource.dart';
import 'package:operatortracker/features/login/data/repositories/login_repository_impl.dart';
import 'package:operatortracker/features/login/domain/repositories/login_repository.dart';
import 'package:operatortracker/features/login/domain/usecases/login_usecase.dart';
import 'package:operatortracker/features/login/presentation/bloc/login_bloc.dart';
import 'features/registrationdevice/data/datasources/installation_remote_datasource.dart';
import 'features/registrationdevice/data/repositories/installation_repository_impl.dart';
import 'features/registrationdevice/domain/repositories/installation_repository.dart';
import 'features/registrationdevice/domain/usecases/check_device_usecase.dart';
import 'features/registrationdevice/domain/usecases/register_device_usecase.dart';
import 'features/registrationdevice/domain/usecases/login_usecase.dart';
import 'features/registrationdevice/domain/usecases/activate_device_usecase.dart';
import 'features/registrationdevice/presentation/bloc/installation_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => InstallationBloc(
      checkDevice: sl(),
      registerDevice: sl(),
      login: sl(),
      activateDevice: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CheckDeviceUseCase(sl()));
  sl.registerLazySingleton(() => RegisterDeviceUseCase(sl()));
  sl.registerLazySingleton(() => LoginAdminUseCase(sl()));
  sl.registerLazySingleton(() => ActivateDeviceUseCase(sl()));

  // Repository
  sl.registerLazySingleton<InstallationRepository>(
    () => InstallationRepositoryImpl(remoteDataSource: sl()),
  );

  // Data source
  sl.registerLazySingleton<InstallationRemoteDataSource>(
    () => InstallationRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());

  // Login Feature
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<WebSocketService>(() => WebSocketService());

  // Chat Feature
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => GetChatMessages(sl()));
  sl.registerLazySingleton(() => SendChatMessage(sl()));
  sl.registerLazySingleton(() => ListenChatMessages(sl()));
  sl.registerFactory(
    () => ChatBloc(getMessages: sl(), sendMessage: sl(), listenMessages: sl()),
  );

  sl.registerLazySingleton(() => SessionManager());

}
