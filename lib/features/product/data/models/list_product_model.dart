import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/core/utils/constants/env.dart';
import 'package:store_demo/core/utils/constants/env.dart';
import 'package:store_demo/core/utils/constants/env.dart';
import 'package:store_demo/features/product/data/models/pagination_model.dart';
import 'package:store_demo/features/product/data/models/product_model.dart';
import 'package:store_demo/features/product/domain/entities/list_product_entity.dart';

class ListProductModel extends ListProductEntity {
  ListProductModel({required super.products, required super.pagination});

  factory ListProductModel.fromJson(Map<String, dynamic> json) {
    return ListProductModel(
      pagination: PaginationModel(
        page: (json['skip'] / int.parse(AppEnv.limitPagination)) + 1,
        totalPage:
            (json['total'] / int.parse(AppEnv.limitPagination)) +
            ((json['total'] % int.parse(AppEnv.limitPagination)) > 0 ? 1.0 : 0),
        total: json['total'] + 0.0,
      ),
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }

  ListProductEntity toEntity() =>
      ListProductEntity(products: products, pagination: pagination);
}
