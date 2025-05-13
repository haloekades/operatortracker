abstract class InstallationEvent {}

class StartInstallation extends InstallationEvent {
  final String deviceId;
  StartInstallation(this.deviceId);
}