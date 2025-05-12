import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_device_usecase.dart';
import '../../domain/usecases/register_device_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/activate_device_usecase.dart';
import 'installation_event.dart';
import 'installation_state.dart';

class InstallationBloc extends Bloc<InstallationEvent, InstallationState> {
  final CheckDeviceUseCase checkDevice;
  final RegisterDeviceUseCase registerDevice;
  final LoginAdminUseCase login;
  final ActivateDeviceUseCase activateDevice;

  InstallationBloc({
    required this.checkDevice,
    required this.registerDevice,
    required this.login,
    required this.activateDevice,
  }) : super(InstallationInitial()) {
    on<StartInstallation>((event, emit) async {
      emit(InstallationLoading(event.deviceId));
      final result = await checkDevice(event.deviceId);
      if (result == null) {
        final success = await registerDevice(event.deviceId);
        if (success) {
          emit(InstallationAwaitingActivation(event.deviceId));
        } else {
          emit(InstallationFailure('Failed to register device'));
        }
      } else {
        if (result.isActive) {
          emit(InstallationSuccess());
        } else {
          emit(InstallationAwaitingActivation(result.id));
        }
      }
    });

    on<SubmitActivation>((event, emit) async {
      final loginSuccess = await login();
      print("ekadestest: loginSuccess $loginSuccess");
      if (loginSuccess) {
        final activated = await activateDevice(event.deviceId);
        print("ekadestest: activated $activated");
        if (activated) {
          emit(InstallationSuccess());
        } else {
          emit(InstallationFailure('Activation failed'));
        }
      } else {
        emit(InstallationFailure('Login failed'));
      }
    });
  }
}