import 'package:operatortracker/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<LoginEntity> loginTabletUnit({
    required String unitId,
    required String nik,
    required String shiftId,
    required int loginType,
  });
}
