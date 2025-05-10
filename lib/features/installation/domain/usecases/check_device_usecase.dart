import '../entities/device_entity.dart';
import '../repositories/installation_repository.dart';

class CheckDeviceUseCase {
  final InstallationRepository repository;

  CheckDeviceUseCase(this.repository);

  Future<DeviceEntity?> call(String deviceId) async {
    return repository.checkDevice(deviceId);
  }
}