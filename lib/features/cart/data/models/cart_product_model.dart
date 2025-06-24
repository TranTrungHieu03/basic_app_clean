import 'package:store_demo/features/cart/domain/entities/cart_product_entity.dart';

class CartProductModel {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double? total;
  final double? discountPercentage;
  final double? discountedTotal;
  final String thumbnail;

  CartProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  CartProductModel copyWith({
    int? id,
    String? title,
    double? price,
    int? quantity,
    double? total,
    double? discountPercentage,
    double? discountedTotal,
    String? thumbnail,
  }) => CartProductModel(
    id: id ?? this.id,
    title: title ?? this.title,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    total: total ?? this.total,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    discountedTotal: discountedTotal ?? this.discountedTotal,
    thumbnail: thumbnail ?? this.thumbnail,
  );

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        total: json["total"]?.toDouble(),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        discountedTotal: json["discountedTotal"]?.toDouble(),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "quantity": quantity,
    "total": total,
    "discountPercentage": discountPercentage,
    "discountedTotal": discountedTotal,
    "thumbnail": thumbnail,
  };

  CartProductEntity toEntity() => CartProductEntity(
    id: id,
    title: title,
    price: price,
    quantity: quantity,
    total: total ?? 0,
    discountPercentage: discountPercentage ?? 0,
    discountedTotal: discountedTotal ?? 0,
    thumbnail: thumbnail,
  );
}
