import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bookia_app/core/constants/AppConstant.dart';
import 'package:bookia_app/feature/auth/data/models/request/RegisterParams.dart';
import 'package:bookia_app/feature/auth/data/models/request/loginParams.dart';
import 'package:bookia_app/feature/auth/data/models/response/register_response_model/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  static Future<RegisterResponseModel?> register(RegisterParams params) async {
    try {
      Uri url = Uri.parse(AppConstant.BaseUrl + AppConstant.RegisterEndpoint);
      var response = await http.post(url, body: params.toJson());
      log(response.body);
      if (response.statusCode == 201) {
        var jsonBody = jsonDecode(response.body);
        log(jsonBody.toString());
        return RegisterResponseModel.fromJson(jsonBody);
      } else {
        log(response.body.toString());
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
      Uri Url = Uri.parse(AppConstant.BaseUrl + AppConstant.LoginEndpoint);
      var response = await http.post(Url, body: params.toJson());
      log(response.body);
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        return RegisterResponseModel.fromJson(jsonBody);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
