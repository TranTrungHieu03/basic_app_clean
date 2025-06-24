import 'package:dartz/dartz.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/features/cart/domain/entities/cart_entity.dart';
import 'package:store_demo/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store_demo/features/cart/domain/usecases/get_cart_by_user.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCarts(GetCartByUserDto params);

  Future<Either<Failure, CartEntity>> addToCart(AddToCartDto params);
}
