import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<LoginEntity> loginTabletUnit({
    required String unitId,
    required String nik,
    required String shiftId,
    required int loginType,
  }) async {
    try {
      final model = await remoteDataSource.loginTabletUnit(
        unitId: unitId,
        nik: nik,
        shiftId: shiftId,
        loginType: loginType,
      );
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
