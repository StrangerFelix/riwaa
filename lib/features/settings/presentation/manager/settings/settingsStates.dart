abstract class SettingsStates {}

class SettingsInitial extends SettingsStates {}
class SignOutLoading extends SettingsStates {}
class SignOutSuccess extends SettingsStates {}
class SignOutFailure extends SettingsStates {
  final String error;
  SignOutFailure(this.error);
}