
class DimensionEntity {
  final double width;
  final double height;
  final double depth;

  DimensionEntity({
    required this.width,
    required this.height,
    required this.depth,
  });

  DimensionEntity copyWith({
    double? width,
    double? height,
    double? depth,
  }) =>
      DimensionEntity(
        width: width ?? this.width,
        height: height ?? this.height,
        depth: depth ?? this.depth,
      );
}
