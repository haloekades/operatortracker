import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<LoginEntity> execute({
    required String unitId,
    required String nik,
    required String shiftId,
    required int loginType,
  }) async {
    return await repository.loginTabletUnit(
      unitId: unitId,
      nik: nik,
      shiftId: shiftId,
      loginType: loginType,
    );
  }
}
