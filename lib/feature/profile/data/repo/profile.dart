import 'dart:developer';
import 'package:bookia_app/core/constants/AppConstant.dart';
import 'package:bookia_app/core/services/AppLocalStorage.dart';
import 'package:bookia_app/core/services/dio_provider.dart';
import 'package:bookia_app/feature/profile/data/models/response/show_profile_response_model/show_profile_response_model.dart';

class ProfileRepo {

 static Future<ShowProfileResponseModel?> showProfile() async {
   try {
  var response=await DioProvider.get(endpoint: AppConstant.showProfile,header: {
    'Authorization':
           'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
  });
  if(response.statusCode==200){
   return ShowProfileResponseModel.fromJson(response.data);
  }else{
   return null;
  }
} on Exception catch (e) {
  log(e.toString());
  return null;
}
 }

 static Future<bool> logoutProfile() async {
   try {
  var response=await DioProvider.post(endpoint: AppConstant.logout,header: {
    'Authorization':
           'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
  });
  if(response.statusCode==200){
   return true;
  }else{
   return false;
  }
} on Exception catch (e) {
  log(e.toString());
  return false;
}
 }
}
