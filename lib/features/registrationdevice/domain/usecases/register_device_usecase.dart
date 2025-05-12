import '../repositories/installation_repository.dart';

class RegisterDeviceUseCase {
  final InstallationRepository repository;

  RegisterDeviceUseCase(this.repository);

  Future<bool> call(String deviceId) async {
    return repository.registerDevice(deviceId);
  }
}