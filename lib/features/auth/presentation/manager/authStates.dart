abstract class AuthStates {}
class AuthInitial extends AuthStates {}

class LoginLoading extends AuthStates {}
class LoginSuccess extends AuthStates {}
class LoginFailure extends AuthStates {
  final String error;
  LoginFailure(this.error);
}

class RegisterLoading extends AuthStates {}
class RegisterSuccess extends AuthStates {}
class RegisterFailure extends AuthStates {
  final String error;
  RegisterFailure(this.error);
}