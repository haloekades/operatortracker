import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/registrationdevice/domain/entities/device_entity.dart';
import 'package:operatortracker/features/registrationdevice/presentation/bloc/installation_bloc.dart';
import 'package:operatortracker/features/registrationdevice/presentation/bloc/installation_event.dart';
import 'package:operatortracker/features/registrationdevice/presentation/bloc/installation_state.dart';

import '../../../mocks/mock_registration_device.mocks.dart';

void main() {
  late MockCheckDeviceUseCase mockCheckDevice;
  late MockRegisterDeviceUseCase mockRegisterDevice;
  late InstallationBloc bloc;

  setUp(() {
    mockCheckDevice = MockCheckDeviceUseCase();
    mockRegisterDevice = MockRegisterDeviceUseCase();
    bloc = InstallationBloc(
      checkDevice: mockCheckDevice,
      registerDevice: mockRegisterDevice,
    );
  });

  const deviceId = 'test-device';

  group('InstallationBloc', () {
    blocTest<InstallationBloc, InstallationState>(
      'emits InstallationAwaitingActivation when device is not found and registration succeeds',
      build: () {
        when(mockCheckDevice.call(deviceId)).thenAnswer((_) async => null);
        when(mockRegisterDevice.call(deviceId)).thenAnswer((_) async => true);

        return InstallationBloc(
          checkDevice: mockCheckDevice,
          registerDevice: mockRegisterDevice,
        );
      },
      act: (bloc) => bloc.add(StartInstallation(deviceId)),
      expect:
          () => [
            isA<InstallationLoading>(),
            isA<InstallationAwaitingActivation>(),
          ],
    );

    blocTest<InstallationBloc, InstallationState>(
      'emits [Loading, Failure] when device not registered and registration fails',
      build: () {
        when(mockCheckDevice.call(deviceId)).thenAnswer((_) async => null);
        when(mockRegisterDevice.call(deviceId)).thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(StartInstallation(deviceId)),
      expect: () => [isA<InstallationLoading>(), isA<InstallationFailure>()],
    );

    blocTest<InstallationBloc, InstallationState>(
      'emits [Loading, Success] when device is active',
      build: () {
        when(
          mockCheckDevice.call(deviceId),
        ).thenAnswer((_) async => DeviceEntity(id: deviceId, isActive: true));
        return bloc;
      },
      act: (bloc) => bloc.add(StartInstallation(deviceId)),
      expect: () => [isA<InstallationLoading>(), isA<InstallationSuccess>()],
    );

    blocTest<InstallationBloc, InstallationState>(
      'emits [Loading, AwaitingActivation] when device is inactive',
      build: () {
        when(
          mockCheckDevice.call(deviceId),
        ).thenAnswer((_) async => DeviceEntity(id: deviceId, isActive: false));
        return bloc;
      },
      act: (bloc) => bloc.add(StartInstallation(deviceId)),
      expect:
          () => [
            isA<InstallationLoading>(),
            isA<InstallationAwaitingActivation>(),
          ],
    );
  });
}
