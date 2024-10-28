class AuthState {}

class AuthInitial extends AuthState {}

// register
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFiler extends AuthState {
  final String error;
  RegisterFiler(this.error) {
    //
  }
}

//login
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFiler extends AuthState {
  final String? error;
  LoginFiler(this.error) {
    //
  }
}

//forgot password
class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordLoaded extends AuthState {}

class ForgotPasswordError extends AuthState {}

//otp
class OtpLoading extends AuthState {}

class OtpLoaded extends AuthState {}

class OtpError extends AuthState {}

//reset password
class ResetPasswordLoading extends AuthState {}

class ResetPasswordLoaded extends AuthState {}

class ResetPasswordError extends AuthState {}
