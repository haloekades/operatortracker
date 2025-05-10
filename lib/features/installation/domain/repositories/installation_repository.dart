import '../entities/device_entity.dart';

abstract class InstallationRepository {
  Future<DeviceEntity?> checkDevice(String deviceId);
  Future<bool> registerDevice(String deviceId);
  Future<bool> login(String nik, String password);
  Future<bool> activateDevice(String deviceId);
}