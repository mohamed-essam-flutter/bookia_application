import 'dart:async';
import 'package:bookia_app/core/constants/AppConstant.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(baseUrl: AppConstant.BaseUrl));
  }

  static Future<Response> get(
      {required String endpoint, Map<String, dynamic>? header}) async {
    return await dio.get(endpoint, options: Options(headers: header));
  }

  static Future<Response> post(
      {required String endpoint,
       Map<String, dynamic>? data,
      Map<String, dynamic>? header}) async {
    return await dio.post(endpoint,
        data: data, options: Options(headers: header));
  }
}
