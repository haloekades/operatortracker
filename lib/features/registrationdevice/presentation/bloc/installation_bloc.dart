import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_device_usecase.dart';
import '../../domain/usecases/register_device_usecase.dart';
import 'installation_event.dart';
import 'installation_state.dart';

class InstallationBloc extends Bloc<InstallationEvent, InstallationState> {
  final CheckDeviceUseCase checkDevice;
  final RegisterDeviceUseCase registerDevice;

  InstallationBloc({
    required this.checkDevice,
    required this.registerDevice,
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
  }
}