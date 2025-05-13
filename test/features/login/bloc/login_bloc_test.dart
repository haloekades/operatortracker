import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/login/domain/entities/login_entity.dart';
import 'package:operatortracker/features/login/presentation/bloc/login_bloc.dart';

import '../../../mocks/mock_login.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  group('LoginBloc', () {
    final loginEntity = LoginEntity(
      id: '123',
      nik: 'EK4NIK000',
      name: 'John Doe',
      roleName: 'Operator',
      email: 'ek4@gmail.com',
      phone: '081000000001',
      unitId: '123455',
      unitCode: '829201',
      isActive: true,
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login succeeds',
      build: () {
        when(mockLoginUseCase.execute(
          unitId: anyNamed('unitId'),
          nik: anyNamed('nik'),
          shiftId: anyNamed('shiftId'),
          loginType: anyNamed('loginType'),
        )).thenAnswer((_) async => loginEntity);

        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) => bloc.add(LoginSubmitted("EK4NIK000")),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginSuccess>().having((s) => s.user.nik, 'nik', "EK4NIK000"),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginError] when login fails',
      build: () {
        when(mockLoginUseCase.execute(
          unitId: anyNamed('unitId'),
          nik: anyNamed('nik'),
          shiftId: anyNamed('shiftId'),
          loginType: anyNamed('loginType'),
        )).thenThrow(Exception("Login failed"));

        return LoginBloc(loginUseCase: mockLoginUseCase);
      },
      act: (bloc) => bloc.add(LoginSubmitted("invalid")),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>().having((e) => e.message, 'message', contains("Login failed")),
      ],
    );
  });
}
