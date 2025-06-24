import 'package:store_demo/features/cart/data/models/cart_product_model.dart';
import 'package:store_demo/features/cart/domain/entities/cart_entity.dart';

class CartModel {
  final int id;
  final List<CartProductModel> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  CartModel({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  CartModel copyWith({
    int? id,
    List<CartProductModel>? products,
    double? total,
    double? discountedTotal,
    int? userId,
    int? totalProducts,
    int? totalQuantity,
  }) => CartModel(
    id: id ?? this.id,
    products: products ?? this.products,
    total: total ?? this.total,
    discountedTotal: discountedTotal ?? this.discountedTotal,
    userId: userId ?? this.userId,
    totalProducts: totalProducts ?? this.totalProducts,
    totalQuantity: totalQuantity ?? this.totalQuantity,
  );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    products: (json["products"] as List)
        .map((x) => CartProductModel.fromJson(x))
        .toList(),
    total: json["total"],
    discountedTotal: json["discountedTotal"],
    userId: json["userId"],
    totalProducts: json["totalProducts"],
    totalQuantity: json["totalQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "products": List<CartProductModel>.from(products.map((x) => x.toJson())),
    "total": total,
    "discountedTotal": discountedTotal,
    "userId": userId,
    "totalProducts": totalProducts,
    "totalQuantity": totalQuantity,
  };

  CartEntity toEntity() => CartEntity(
    id: id,
    products: products.map((e) => e.toEntity()).toList(),
    total: total,
    discountedTotal: discountedTotal,
    userId: userId,
    totalProducts: totalProducts,
    totalQuantity: totalQuantity,
  );
}
