import 'package:store_demo/features/product/domain/entities/meta_entity.dart';

class MetaModel extends MetaEntity {
  MetaModel({
    required super.createdAt,
    required super.updatedAt,
    required super.barcode,
    required super.qrCode,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    barcode: json["barcode"],
    qrCode: json["qrCode"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "barcode": barcode,
    "qrCode": qrCode,
  };

  MetaEntity toEntity() => MetaEntity(
    createdAt: createdAt,
    updatedAt: updatedAt,
    barcode: barcode,
    qrCode: qrCode,
  );
}
