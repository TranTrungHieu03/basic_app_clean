import 'package:store_demo/features/product/domain/entities/dimension_entity.dart';
import 'package:store_demo/features/product/domain/entities/meta_entity.dart';
import 'package:store_demo/features/product/domain/entities/review_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String? brand;
  final String sku;
  final int weight;
  final DimensionEntity dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final List<String> images;
  final String thumbnail;
  final MetaEntity meta;
  final List<ReviewEntity> reviews;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
      this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.images,
    required this.thumbnail,
    required this.meta,
    required this.reviews,
  });

  ProductEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    int? weight,
    DimensionEntity? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    String? returnPolicy,
    int? minimumOrderQuantity,
    List<String>? images,
    String? thumbnail,
    MetaEntity? meta,
    List<ReviewEntity>? reviews,
  }) => ProductEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    price: price ?? this.price,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    rating: rating ?? this.rating,
    stock: stock ?? this.stock,
    tags: tags ?? this.tags,
    brand: brand ?? this.brand,
    sku: sku ?? this.sku,
    weight: weight ?? this.weight,
    dimensions: dimensions ?? this.dimensions,
    warrantyInformation: warrantyInformation ?? this.warrantyInformation,
    shippingInformation: shippingInformation ?? this.shippingInformation,
    availabilityStatus: availabilityStatus ?? this.availabilityStatus,
    returnPolicy: returnPolicy ?? this.returnPolicy,
    minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
    images: images ?? this.images,
    thumbnail: thumbnail ?? this.thumbnail,
    meta: meta ?? this.meta,
    reviews: reviews ?? this.reviews,
  );
}
