import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookia_app/feature/home/data/models/response/best_seller_response_model/best_seller_response_model.dart';
import 'package:bookia_app/feature/home/data/models/response/home_banner_response_model/home_banner_response_model.dart';
import 'package:bookia_app/feature/home/data/models/response/show_cart_response_model/show_cart_response_model.dart';
import 'package:bookia_app/feature/home/data/models/response/show_wishlist_response_model/show_wishlist_response_model.dart';
import 'package:bookia_app/feature/home/data/repo/HomeRepo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<BestSellerEvent>(bestSeller);
    on<HomeBannerEvent>(homeBanner);
    on<AddToWishlist>(addToWishlist);
    on<RemoveFromWishlist>(removeFromWishlist);
    on<ShowWishlistEvent>(shoWWishlist);
    on<AddToCartEvent>(addToCart);
    on<ShowCartEvent>(showCart);
    on<RemoveFromCartEvent>(removeFromCart);
  }

  BestSellerResponseModel? bestSellerResponseModel;
  HomeBannerResponseModel? homeBannerResponseModel;
  ShowWishlistResponseModel? showWishlistResponseModel;
  ShowCartResponseModel? showCartResponseModel;

  Future<void> bestSeller(
      BestSellerEvent event, Emitter<HomeState> emit) async {
    emit(BestSellerLoadingState());
    //api
    await HomeRepo.getBestSeller().then(
      (value) {
        if (value != null) {
          bestSellerResponseModel = value;
          emit(BestSellerLoadedState());
        } else {
          emit(BestSellerErrorState());
        }
      },
    );
  }

  Future<void> homeBanner(
      HomeBannerEvent event, Emitter<HomeState> emit) async {
    await HomeRepo.getHomeBanner().then(
      (value) {
        if (value != null) {
          homeBannerResponseModel = value;
          emit(HomeBannerLoadedState());
        } else {
          emit(HomeBannerErrorState());
        }
      },
    );
  }

  Future<void> addToWishlist(
      AddToWishlist event, Emitter<HomeState> emit) async {
    emit(AddToWishlistLoadingState());
    //api
    await HomeRepo.add_wishlist(products_id: event.product_id).then(
      (value) {
        if (value) {
          emit(AddToWishlistLoadedState());
        } else {
          emit(AddToWishlistErrorState());
        }
      },
    );
  }

  Future<void> removeFromWishlist(
      RemoveFromWishlist event, Emitter<HomeState> emit) async {
    emit(RemoveFromWishlistLoadingState());
    //api
    await HomeRepo.remove_wishlist(product_id: event.product_id).then(
      (value) {
        if (value) {
          emit(RemoveFromWishlistLoadedState());
        } else {
          emit(RemoveFromWishlistErrorState());
        }
      },
    );
  }

  Future<void> shoWWishlist(
      ShowWishlistEvent event, Emitter<HomeState> emit) async {
    emit(ShowWishlistLoadingState());
    //api
    await HomeRepo.show_wishlist().then(
      (value) {
        if (value != null) {
          showWishlistResponseModel = value;
          emit(ShowWishlistLoadedState());
        } else {
          emit(ShowWishlistErrorState());
        }
      },
    );
  }

  //AddToCart
  Future<void> addToCart(AddToCartEvent event, Emitter<HomeState> emit) async {
    emit(AddToCartLoadingState());
    //api
    await HomeRepo.add_cart(event.product_id).then(
      (value) {
        if (value) {
          emit(AddToCartLoadedState());
        } else {
          emit(AddToCartErrorState());
        }
      },
    );
  }

  //remove from cart
  Future<void> removeFromCart(
      RemoveFromCartEvent event, Emitter<HomeState> emit) async {
    emit(RemoveFromCartLoadingState());
    //api
    await HomeRepo.remove_cart(event.cart_item_id).then(
      (value) {
        if (value) {
          emit(RemoveFromCartLoadedState());
        } else {
          emit(RemoveFromCartErrorState());
        }
      },
    );
  }

  Future<void> showCart(ShowCartEvent event, Emitter<HomeState> emit) async {
    try {
      emit(ShowCartLoadingState());
      //api
      await HomeRepo.show_cart().then(
        (value) {
          if (value != null) {
            showCartResponseModel = value;
            emit(ShowCartLoadedState());
          } else {
            emit(ShowCartErrorState());
          }
        },
      );
    } on Exception catch (e) {
      log(e.toString());
      emit(ShowCartErrorState());
    }
  }
}
