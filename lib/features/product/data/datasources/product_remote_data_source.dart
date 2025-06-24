import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/core/errors/exceptions.dart';
import 'package:store_demo/core/network/dio_api_services.dart';
import 'package:store_demo/core/response/api_response.dart';
import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/features/product/data/models/category_model.dart';
import 'package:store_demo/features/product/data/models/list_product_model.dart';
import 'package:store_demo/features/product/data/models/product_model.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';
import 'package:store_demo/features/product/domain/usecases/get_list_product.dart';
import 'package:store_demo/features/product/domain/usecases/get_product_detail.dart';
import 'package:store_demo/features/product/domain/usecases/search_product_by_category.dart';

abstract class ProductRemoteDataSource {
  Future<ListProductModel> getProducts(GetListProductDto params);

  Future<ListProductModel> searchProductsByCategory(
    SearchProductByCategoryDto params,
  );

  Future<ProductModel> getProductDetail(GetProductDetailParams params);

  Future<List<CategoryModel>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioApiServices _apiServices;

  ProductRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ProductModel> getProductDetail(params) async {
    try {
      final response = await _apiServices.get(
        "products/${params.productId}",
        {},
      );

      final responseFormat = ApiResponse.fromJson(response);
      if (responseFormat.message != null) {
        throw AppException(responseFormat.message);
      }
      return ProductModel.fromJson(responseFormat.data);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<ListProductModel> getProducts(params) async {
    try {
      final response = await _apiServices.get("products", params.toJson());

      final responseFormat = ApiResponse.fromJson(response);
      if (responseFormat.message != null) {
        throw AppException(responseFormat.message);
      }
      return ListProductModel.fromJson(responseFormat.data);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiServices.get("products/categories", {});

      return (response as List).map((e) {
        return CategoryModel.fromJson(e);
      }).toList();
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<ListProductModel> searchProductsByCategory(
    SearchProductByCategoryDto params,
  ) async {
    try {
      final response = await _apiServices.get(
        "products/category/${params.type}",
        params.toJson(),
      );

      final responseFormat = ApiResponse.fromJson(response);
      AppLogger.debug(responseFormat);
      if (responseFormat.message != null) {
        throw AppException(responseFormat.message);
      }
      return ListProductModel.fromJson(responseFormat.data);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
