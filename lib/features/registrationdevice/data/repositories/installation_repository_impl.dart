import '../../domain/entities/device_entity.dart';
import '../../domain/repositories/installation_repository.dart';
import '../datasources/installation_remote_datasource.dart';

class InstallationRepositoryImpl implements InstallationRepository {
  final InstallationRemoteDataSource remoteDataSource;

  InstallationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DeviceEntity?> checkDevice(String deviceId) async {
    return await remoteDataSource.checkDevice(deviceId);
  }

  @override
  Future<bool> registerDevice(String deviceId) async {
    return await remoteDataSource.registerDevice(deviceId);
  }

  @override
  Future<bool> loginAdmin(String nik, String password) async {
    return await remoteDataSource.loginAdmin(nik, password);
  }

  @override
  Future<bool> activateDevice(String deviceId) async {
    return await remoteDataSource.activateDevice(deviceId);
  }
}