abstract class InstallationEvent {}

class StartInstallation extends InstallationEvent {
  final String deviceId;
  StartInstallation(this.deviceId);
}

class SubmitActivation extends InstallationEvent {
  final String deviceId;
  SubmitActivation({required this.deviceId});
}