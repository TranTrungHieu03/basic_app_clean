import 'package:store_demo/core/errors/exceptions.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/core/network/dio_api_services.dart';
import 'package:store_demo/core/response/api_response.dart';
import 'package:store_demo/features/cart/data/models/cart_model.dart';
import 'package:store_demo/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store_demo/features/cart/domain/usecases/get_cart_by_user.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCarts(GetCartByUserDto params);

  Future<CartModel> addToCart(AddToCartDto params);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final DioApiServices _apiServices;

  CartRemoteDataSourceImpl(this._apiServices);

  @override
  Future<CartModel> addToCart(AddToCartDto params) async {
    try {
      final response = await _apiServices.put(
        'carts/${params.userId}',
        params.toJson(),
      );

      final responseFormat = ApiResponse.fromJson(response);
      if (responseFormat.message != null) {
        throw ApiFailure(message: responseFormat.message!);
      }
      return CartModel.fromJson(responseFormat.data);
    } on AppException catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }

  @override
  Future<CartModel> getCarts(GetCartByUserDto params) async {
    try {
      final response = await _apiServices.get('carts/${params.userId}', {});

      final responseFormat = ApiResponse.fromJson(response);
      if (responseFormat.message != null) {
        throw ApiFailure(message: responseFormat.message!);
      }
      return CartModel.fromJson(responseFormat.data);
    } on AppException catch (e) {
      throw ApiFailure(message: e.toString());
    }
  }
}
