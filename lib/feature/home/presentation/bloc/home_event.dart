part of 'home_bloc.dart';

class HomeEvent {}

class BestSellerEvent extends HomeEvent {}

class HomeBannerEvent extends HomeEvent {}

class AddToWishlist extends HomeEvent {
  // ignore: non_constant_identifier_names
  final int product_id;
  AddToWishlist(this.product_id);
}

class RemoveFromWishlist extends HomeEvent {
  // ignore: non_constant_identifier_names
  final int product_id;
  RemoveFromWishlist(this.product_id);
}

class ShowWishlistEvent extends HomeEvent {}

//AddToCart

class AddToCartEvent extends HomeEvent {
  // ignore: non_constant_identifier_names
  final int product_id;
  AddToCartEvent(this.product_id);
}

class RemoveFromCartEvent extends HomeEvent {
  // ignore: non_constant_identifier_names
  final int cart_item_id;
  RemoveFromCartEvent(this.cart_item_id);
}

class ShowCartEvent extends HomeEvent {}
