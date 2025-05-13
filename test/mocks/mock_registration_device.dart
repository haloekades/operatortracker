import 'package:mockito/annotations.dart';
import 'package:operatortracker/features/registrationdevice/domain/repositories/installation_repository.dart';
import 'package:operatortracker/features/registrationdevice/domain/usecases/check_device_usecase.dart';
import 'package:operatortracker/features/registrationdevice/domain/usecases/register_device_usecase.dart';

@GenerateMocks([InstallationRepository, CheckDeviceUseCase, RegisterDeviceUseCase])
void main() {}