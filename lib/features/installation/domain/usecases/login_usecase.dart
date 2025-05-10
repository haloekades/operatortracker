import '../repositories/installation_repository.dart';

class LoginUseCase {
  final InstallationRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String nik, String password) async {
    return repository.login(nik, password);
  }
}
