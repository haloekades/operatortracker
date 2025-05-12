abstract class InstallationState {}

class InstallationInitial extends InstallationState {}
class InstallationLoading extends InstallationState {
  final String deviceId;
  InstallationLoading(this.deviceId);
}
class InstallationAwaitingActivation extends InstallationState {
  final String deviceId;
  InstallationAwaitingActivation(this.deviceId);
}
class InstallationSuccess extends InstallationState {}
class InstallationFailure extends InstallationState {
  final String message;
  InstallationFailure(this.message);
}