import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/registrationdevice/domain/usecases/register_device_usecase.dart';

import '../../../mocks/mock_registration_device.mocks.dart';

void main() {
  late MockInstallationRepository mockRepository;
  late RegisterDeviceUseCase usecase;

  setUp(() {
    mockRepository = MockInstallationRepository();
    usecase = RegisterDeviceUseCase(mockRepository);
  });

  test('should return true when registration is successful', () async {
    const deviceId = 'device123';

    when(mockRepository.registerDevice(deviceId)).thenAnswer((_) async => true);

    final result = await usecase.call(deviceId);

    expect(result, isTrue);
    verify(mockRepository.registerDevice(deviceId)).called(1);
  });

  test('should return false when registration fails', () async {
    const deviceId = 'device123';

    when(mockRepository.registerDevice(deviceId)).thenAnswer((_) async => false);

    final result = await usecase.call(deviceId);

    expect(result, isFalse);
    verify(mockRepository.registerDevice(deviceId)).called(1);
  });
}
