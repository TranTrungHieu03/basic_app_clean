import 'package:store_demo/features/product/domain/entities/dimension_entity.dart';

class DimensionModel extends DimensionEntity {
  DimensionModel({
    required super.width,
    required super.height,
    required super.depth,
  });

  factory DimensionModel.fromJson(Map<String, dynamic> json) => DimensionModel(
    width: json["width"]?.toDouble(),
    height: json["height"]?.toDouble(),
    depth: json["depth"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "depth": depth,
  };

  DimensionEntity toEntity() =>
      DimensionEntity(width: width, height: height, depth: depth);
}
