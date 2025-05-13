import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:operatortracker/features/registrationdevice/domain/entities/device_entity.dart';
import 'package:operatortracker/features/registrationdevice/domain/usecases/check_device_usecase.dart';

import '../../../mocks/mock_registration_device.mocks.dart';

void main() {
  late MockInstallationRepository mockRepository;
  late CheckDeviceUseCase usecase;

  setUp(() {
    mockRepository = MockInstallationRepository();
    usecase = CheckDeviceUseCase(mockRepository);
  });

  test('should return DeviceEntity from repository', () async {
    const deviceId = 'device123';
    final deviceEntity = DeviceEntity(id: deviceId, isActive: true);

    when(
      mockRepository.checkDevice(deviceId),
    ).thenAnswer((_) async => deviceEntity);

    final result = await usecase.call(deviceId);

    expect(result, equals(deviceEntity));
    verify(mockRepository.checkDevice(deviceId)).called(1);
  });

  test('should return null if device not found', () async {
    const deviceId = 'unknown-device';

    when(mockRepository.checkDevice(deviceId)).thenAnswer((_) async => null);

    final result = await usecase.call(deviceId);

    expect(result, isNull);
    verify(mockRepository.checkDevice(deviceId)).called(1);
  });
}
