abstract class InstallationEvent {}

class StartInstallation extends InstallationEvent {
  final String deviceId;
  StartInstallation(this.deviceId);
}

class SubmitActivation extends InstallationEvent {
  final String nik;
  final String password;
  final String deviceId;
  SubmitActivation({required this.nik, required this.password, required this.deviceId});
}