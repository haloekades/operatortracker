import '../repositories/installation_repository.dart';

class ActivateDeviceUseCase {
  final InstallationRepository repository;

  ActivateDeviceUseCase(this.repository);

  Future<bool> call(String deviceId) async {
    return repository.activateDevice(deviceId);
  }
}
