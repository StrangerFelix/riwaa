import 'package:riwaa/features/settings/data/models/userModel.dart';

abstract class SettingsStates {}

class SettingsInitial extends SettingsStates {}
class SignOutLoading extends SettingsStates {}
class SignOutSuccess extends SettingsStates {}
class SignOutFailure extends SettingsStates {
  final String error;
  SignOutFailure(this.error);
}

class GetUserDataLoading extends SettingsStates {}
class GetUserDataSuccess extends SettingsStates {
  final UserModel model;
  GetUserDataSuccess(this.model);
}
class GetUserDataFailure extends SettingsStates {
  final String error;
  GetUserDataFailure(this.error);
}