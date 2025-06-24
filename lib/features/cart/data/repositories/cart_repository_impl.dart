import 'package:dartz/dartz.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:store_demo/features/cart/domain/entities/cart_entity.dart';
import 'package:store_demo/features/cart/domain/repositories/cart_repository.dart';
import 'package:store_demo/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store_demo/features/cart/domain/usecases/get_cart_by_user.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CartEntity>> addToCart(AddToCartDto params) async {
    try {
      final result = await _remoteDataSource.addToCart(params);
      return right(result.toEntity());
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getCarts(GetCartByUserDto params) async {
    try {
      final result = await _remoteDataSource.getCarts(params);
      return right(result.toEntity());
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
