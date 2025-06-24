import 'package:equatable/equatable.dart';
import 'package:store_demo/features/cart/domain/entities/cart_product_entity.dart';
import 'package:store_demo/features/product/data/models/product_model.dart';

class CartEntity extends Equatable {
  final int id;
  final List<CartProductEntity> products;
  final int total;
  final int discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  const CartEntity({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, total, products];
}
