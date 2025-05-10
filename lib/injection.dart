import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/installation/data/datasources/installation_remote_datasource.dart';
import 'features/installation/data/repositories/installation_repository_impl.dart';
import 'features/installation/domain/repositories/installation_repository.dart';
import 'features/installation/domain/usecases/check_device_usecase.dart';
import 'features/installation/domain/usecases/register_device_usecase.dart';
import 'features/installation/domain/usecases/login_usecase.dart';
import 'features/installation/domain/usecases/activate_device_usecase.dart';
import 'features/installation/presentation/bloc/installation_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => InstallationBloc(
    checkDevice: sl(),
    registerDevice: sl(),
    login: sl(),
    activateDevice: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => CheckDeviceUseCase(sl()));
  sl.registerLazySingleton(() => RegisterDeviceUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => ActivateDeviceUseCase(sl()));

  // Repository
  sl.registerLazySingleton<InstallationRepository>(
          () => InstallationRepositoryImpl(remoteDataSource: sl()));

  // Data source
  sl.registerLazySingleton<InstallationRemoteDataSource>(
          () => InstallationRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
