part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class GetCartByUserEvent extends CartEvent {
  GetCartByUserDto params;

  GetCartByUserEvent(this.params);
}

final class AddToCartEvent extends CartEvent {
  AddToCartDto params;

  AddToCartEvent(this.params);
}
