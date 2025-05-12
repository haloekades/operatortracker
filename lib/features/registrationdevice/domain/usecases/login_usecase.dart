import '../repositories/installation_repository.dart';

class LoginAdminUseCase {
  final InstallationRepository repository;
  final String nik= '12345';
  final String password= 'password';

  LoginAdminUseCase(this.repository);

  Future<bool> call() async {
    return repository.loginAdmin(nik, password);
  }
}
