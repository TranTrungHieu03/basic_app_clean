import 'package:dartz/dartz.dart';
import 'package:store_demo/core/errors/exceptions.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/features/product/data/datasources/product_remote_data_source.dart';
import 'package:store_demo/features/product/data/models/list_product_model.dart';
import 'package:store_demo/features/product/domain/entities/category_entity.dart';
import 'package:store_demo/features/product/domain/entities/list_product_entity.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';
import 'package:store_demo/features/product/domain/repositories/product_repository.dart';
import 'package:store_demo/features/product/domain/usecases/search_product_by_category.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _dataSource;

  ProductRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ListProductEntity>> getListProducts(params) async {
    try {
      final result = await _dataSource.getProducts(params);
      return right(result.toEntity());
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(params) async {
    try {
      final result = await _dataSource.getProductDetail(params);
      return right(result.toEntity());
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getListCategories() async {
    try {
      final result = await _dataSource.getCategories();
      return right(result.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ListProductEntity>> getListProductsByCategory(
    SearchProductByCategoryDto params,
  ) async {
    try {
      final result = await _dataSource.searchProductsByCategory(params);
      return right(result.toEntity());
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
