import 'dart:async';
import 'dart:developer';
import 'package:bookia_app/core/constants/AppConstant.dart';
import 'package:bookia_app/core/services/dio_provider.dart';
import 'package:bookia_app/feature/auth/data/models/request/RegisterParams.dart';
import 'package:bookia_app/feature/auth/data/models/request/loginParams.dart';
import 'package:bookia_app/feature/auth/data/models/response/register_response_model/register_response_model.dart';

class AuthRepo {
  static Future<RegisterResponseModel?> register(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppConstant.RegisterEndpoint, data: params.toJson());
      log(response.data);
      if (response.statusCode == 201) {
        return RegisterResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  //login
  static Future<RegisterResponseModel?> login(LoginParams params) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppConstant.LoginEndpoint, data: params.toJson());
      if (response.statusCode == 200) {
        return RegisterResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  static Future<bool> forgot_password(String email) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppConstant.forgot_password, data: {"email": email});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> otp(int verifyCode) async {
    try {
      var response = await DioProvider.post(
          endpoint: AppConstant.otp, data: {"verify_code": verifyCode});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  static Future<bool> reset_password(
      int verifyCode, int newPassword, int newPasswordConfirmation) async {
    try {
      var response =
          await DioProvider.post(endpoint: AppConstant.resetPassword, data: {
        "verify_code": verifyCode,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
