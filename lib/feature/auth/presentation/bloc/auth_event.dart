import 'package:bookia_app/feature/auth/data/models/request/RegisterParams.dart';
import 'package:bookia_app/feature/auth/data/models/request/loginParams.dart';

class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final RegisterParams params;
  RegisterEvent(this.params);
  //
}

class LoginEvent extends AuthEvent {
  final LoginParams params;
  LoginEvent(this.params);
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

//otp
class OtpEvent extends AuthEvent {
  final int code;
  OtpEvent({required this.code});
}

class ResetPasswordEvent extends AuthEvent {
  final int code;
  final int password;
  final int newPasswordConfirmation;

  ResetPasswordEvent(
      {required this.code,
      required this.password,
      required this.newPasswordConfirmation});
}
