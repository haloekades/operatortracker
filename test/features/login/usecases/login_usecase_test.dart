import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';
import 'package:operatortracker/features/login/domain/usecases/login_usecase.dart';

import '../../../mocks/mock_login.mocks.dart';

void main() {
  late MockLoginRepository mockLoginRepository;
  late LoginUseCase usecase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = LoginUseCase(mockLoginRepository);
  });

  test('should login and return LoginEntity', () async {
    const unitId = 'unit123';
    const nik = 'EMP001';
    const shiftId = 'shiftA';
    const loginType = 1;

    final loginEntity = LoginEntity(
      id: '123',
      nik: nik,
      name: 'John Doe',
      roleName: 'Operator',
      email: 'ek4@gmail.com',
      phone: '081000000001',
      unitId: '123455',
      unitCode: '829201',
      isActive: true,
    );

    when(
      mockLoginRepository.loginTabletUnit(
        unitId: unitId,
        nik: nik,
        shiftId: shiftId,
        loginType: loginType,
      ),
    ).thenAnswer((_) async => loginEntity);

    final result = await usecase.execute(
      unitId: unitId,
      nik: nik,
      shiftId: shiftId,
      loginType: loginType,
    );

    expect(result, equals(loginEntity));
    verify(
      mockLoginRepository.loginTabletUnit(
        unitId: unitId,
        nik: nik,
        shiftId: shiftId,
        loginType: loginType,
      ),
    ).called(1);
  });
}
