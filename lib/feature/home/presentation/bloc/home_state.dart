part of 'home_bloc.dart';

class HomeState {}

final class HomeInitial extends HomeState {}

//best seller
class BestSellerLoadingState extends HomeState {}

class BestSellerLoadedState extends HomeState {}

class BestSellerErrorState extends HomeState {}

//home banner
class HomeBannerLoadedState extends HomeState {}

class HomeBannerErrorState extends HomeState {}

//add to wishlist
class AddToWishlistLoadingState extends HomeState {}

class AddToWishlistLoadedState extends HomeState {}

class AddToWishlistErrorState extends HomeState {}

//remove from wishlist
class RemoveFromWishlistLoadingState extends HomeState {}

class RemoveFromWishlistLoadedState extends HomeState {}

class RemoveFromWishlistErrorState extends HomeState {}

// show wishlist
class ShowWishlistLoadingState extends HomeState {}

class ShowWishlistLoadedState extends HomeState {}

class ShowWishlistErrorState extends HomeState {}

// add to cart
class AddToCartLoadingState extends HomeState {}

class AddToCartLoadedState extends HomeState {}

class AddToCartErrorState extends HomeState {}

//remove from cart
class RemoveFromCartLoadingState extends HomeState {}

class RemoveFromCartLoadedState extends HomeState {}

class RemoveFromCartErrorState extends HomeState {}

//show cart
class ShowCartLoadingState extends HomeState {}

class ShowCartLoadedState extends HomeState {}

class ShowCartErrorState extends HomeState {}
