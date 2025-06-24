import 'package:store_demo/features/product/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.slug, required super.name, required super.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(slug: json["slug"], name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"slug": slug, "name": name, "url": url};

  CategoryEntity toEntity() => CategoryEntity(slug: slug, name: name, url: url);
}
