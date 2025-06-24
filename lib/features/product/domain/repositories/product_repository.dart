import 'package:dartz/dartz.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/features/product/domain/entities/category_entity.dart';
import 'package:store_demo/features/product/domain/entities/list_product_entity.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';
import 'package:store_demo/features/product/domain/usecases/get_list_product.dart';
import 'package:store_demo/features/product/domain/usecases/get_product_detail.dart';
import 'package:store_demo/features/product/domain/usecases/search_product_by_category.dart';

abstract class ProductRepository {
  Future<Either<Failure, ListProductEntity>> getListProducts(
    GetListProductDto params,
  );

  Future<Either<Failure, ListProductEntity>> getListProductsByCategory(
    SearchProductByCategoryDto params,
  );

  Future<Either<Failure, ProductEntity>> getProductDetail(
    GetProductDetailParams params,
  );

  Future<Either<Failure, List<CategoryEntity>>> getListCategories();
}
