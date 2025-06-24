import 'package:store_demo/features/product/domain/entities/pagination.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';

class ListProductEntity {
  List<ProductEntity> products;
  PaginationEntity pagination;

  ListProductEntity({required this.products, required this.pagination});
}
