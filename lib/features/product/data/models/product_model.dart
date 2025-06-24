import 'package:store_demo/features/product/data/models/dimension_model.dart';
import 'package:store_demo/features/product/data/models/meta_model.dart';
import 'package:store_demo/features/product/data/models/review_model.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  // final DimensionModel dimensions;
  // final MetaModel meta;
  // final List<ReviewModel> review;
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    super.brand,
    required super.sku,
    required super.weight,
    required super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.images,
    required super.thumbnail,
    required super.meta,
    required super.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    category: json["category"],
    price: json["price"]?.toDouble(),
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    brand: json["brand"],
    sku: json["sku"],
    weight: json["weight"],
    dimensions: DimensionModel.fromJson(json["dimensions"]),
    warrantyInformation: json["warrantyInformation"],
    shippingInformation: json["shippingInformation"],
    availabilityStatus: json["availabilityStatus"],
    reviews: List<ReviewModel>.from(
      json["reviews"].map((x) => ReviewModel.fromJson(x)),
    ),
    returnPolicy: json["returnPolicy"],
    minimumOrderQuantity: json["minimumOrderQuantity"],
    meta: MetaModel.fromJson(json["meta"]),
    images: List<String>.from(json["images"].map((x) => x)),
    thumbnail: json["thumbnail"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "title": title,
  //   "description": description,
  //   "category": category,
  //   "price": price,
  //   "discountPercentage": discountPercentage,
  //   "rating": rating,
  //   "stock": stock,
  //   "tags": List<dynamic>.from(tags.map((x) => x)),
  //   "brand": brand,
  //   "sku": sku,
  //   "weight": weight,
  //   "dimensions": dimensions.toJson(),
  //   "warrantyInformation": warrantyInformation,
  //   "shippingInformation": shippingInformation,
  //   "availabilityStatus": availabilityStatus,
  //   "reviews": List<ReviewModel>.from(reviews.map((x) => x.toJson())),
  //   "returnPolicy": returnPolicy,
  //   "minimumOrderQuantity": minimumOrderQuantity,
  //   "meta": meta.toJson(),
  //   "images": List<dynamic>.from(images.map((x) => x)),
  //   "thumbnail": thumbnail,
  // };

  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    description: description,
    category: category,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    tags: tags,
    brand: brand,
    sku: sku,
    weight: weight,
    dimensions: dimensions,
    warrantyInformation: warrantyInformation,
    shippingInformation: shippingInformation,
    availabilityStatus: availabilityStatus,
    returnPolicy: returnPolicy,
    minimumOrderQuantity: minimumOrderQuantity,
    images: images,
    thumbnail: thumbnail,
    meta: meta,
    reviews: reviews,
  );
}
