import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase implements UseCase<Either, AddToCartDto> {
  final CartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);

  @override
  Future<Either> call(AddToCartDto params) async {
    return await _cartRepository.addToCart(params);
  }
}

class AddToCartDto {
  final String userId;
  final List<ProductCartDto> products;

  AddToCartDto({required this.userId, required this.products});

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'merge': true,
    "products": products.map((e) => e.toJson()).toList(),
  };
}

class ProductCartDto {
  final int id;
  final int quantity;

  ProductCartDto({required this.quantity, required this.id});

  Map<String, dynamic> toJson() => {'id': id, 'quantity': quantity};
}
