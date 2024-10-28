import 'dart:developer';
import 'package:bookia_app/core/constants/AppConstant.dart';
import 'package:bookia_app/core/services/AppLocalStorage.dart';
import 'package:bookia_app/core/services/dio_provider.dart';
import 'package:bookia_app/feature/home/data/models/response/best_seller_response_model/best_seller_response_model.dart';
import 'package:bookia_app/feature/home/data/models/response/home_banner_response_model/home_banner_response_model.dart';
import 'package:bookia_app/feature/home/data/models/response/show_cart_response_model/show_cart_response_model.dart';
import 'package:bookia_app/feature/home/data/models/response/show_wishlist_response_model/show_wishlist_response_model.dart';

class HomeRepo {
  //handle api
  static Future<BestSellerResponseModel?> getBestSeller() async {
    try {
      var response =
          await DioProvider.get(endpoint: AppConstant.bestSellerEndpoint);
      if (response.statusCode == 200) {
        return BestSellerResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<HomeBannerResponseModel?> getHomeBanner() async {
    try {
      var response =
          await DioProvider.get(endpoint: AppConstant.homeBannerEndpoint);
      if (response.statusCode == 200) {
        return HomeBannerResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  static Future<bool> add_wishlist({required int products_id}) async {
    try {
      var response =
          await DioProvider.post(endpoint: AppConstant.Add_wishlist, data: {
        "product_id": products_id
      }, header: {
        'Authorization':
            'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
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

  // ignore: non_constant_identifier_names
  static Future<bool> remove_wishlist({required int product_id}) async {
    try {
      var response =
          await DioProvider.post(endpoint: AppConstant.remove_wishlist, data: {
        "product_id": product_id
      }, header: {
        'Authorization':
            'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
      });
      if (response.statusCode == 200) {
        log('kkkkkkkkkk');
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log('gggggggggggg');
      log(e.toString());
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  static Future<ShowWishlistResponseModel?> show_wishlist() async {
    try {
      var response =
          await DioProvider.get(endpoint: AppConstant.show_wishlist, header: {
        'Authorization':
            'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
      });
      if (response.statusCode == 200) {
        return ShowWishlistResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  static Future<bool> add_cart(int product_id) async {
    try {
      var response =
          await DioProvider.post(endpoint: AppConstant.add_cart, data: {
        "product_id": product_id
      }, header: {
        'Authorization':
            'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
      });
      if (response.statusCode == 201) {
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
  static Future<bool> remove_cart(int cartItemId) async {
    try {
      var response =
          await DioProvider.post(endpoint: AppConstant.remove_cart, data: {
        "cart_item_id": cartItemId
      }, header: {
        'Authorization':
            'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
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

  // ignore: non_constant_identifier_names
  static Future<ShowCartResponseModel?> show_cart() async {
    try {
      var response =
          await DioProvider.get(endpoint: AppConstant.show_cart, header: {
        'Authorization':
            'Bearer ${AppLocalStorage.getCache(key: AppLocalStorage.token)}'
      });
      if (response.statusCode == 200) {
        return ShowCartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
