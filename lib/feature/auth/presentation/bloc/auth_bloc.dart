import 'dart:developer';

import 'package:bookia_app/core/services/AppLocalStorage.dart';
import 'package:bookia_app/feature/auth/data/repo/auth_repo.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:bookia_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
    on<ForgotPasswordEvent>(forgot_password);
    on<OtpEvent>(otp);
    on<ResetPasswordEvent>(resetPassword);
  }
}

Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
  emit(RegisterLoading());
  // logic
  await AuthRepo.register(event.params).then(
    (value) {
      log(value.toString());
      if (value != null) {
        AppLocalStorage.cacheData(
            key: AppLocalStorage.token, value: value.data?.token);
        emit(RegisterSuccess());
      } else {
        emit(RegisterFiler('Found error'));
      }
    },
  );
}

Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
  emit(LoginLoading());
  await AuthRepo.login(event.params).then((value) {
    if (value != null) {
      AppLocalStorage.cacheData(
          key: AppLocalStorage.token, value: value.data?.token);
      emit(LoginSuccess());
    } else {
      emit(LoginFiler("Found error"));
    }
  });
}

Future<void> forgot_password(
    ForgotPasswordEvent event, Emitter<AuthState> emit) async {
  emit(ForgotPasswordLoading());
  await AuthRepo.forgot_password(event.email).then((value) {
    if (value) {
      emit(ForgotPasswordLoaded());
    } else {
      emit(ForgotPasswordError());
    }
  });
}

Future<void> otp(OtpEvent event, Emitter<AuthState> emit) async {
  emit(OtpLoading());
  await AuthRepo.otp(event.code).then((value) {
    if (value) {
      emit(OtpLoaded());
    } else {
      emit(OtpError());
    }
  });
}

Future<void> resetPassword(
    ResetPasswordEvent event, Emitter<AuthState> emit) async {
  emit(ResetPasswordLoading());
  await AuthRepo.reset_password(
          event.code, event.password, event.newPasswordConfirmation)
      .then((value) {
    if (value) {
      emit(ResetPasswordLoaded());
    } else {
      emit(ResetPasswordError());
    }
  });
}
