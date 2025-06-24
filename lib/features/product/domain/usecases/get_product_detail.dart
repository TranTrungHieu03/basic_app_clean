import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/product/domain/repositories/product_repository.dart';

class GetProductDetail implements UseCase<Either, GetProductDetailParams> {
  final ProductRepository _productRepository;

  GetProductDetail(this._productRepository);

  @override
  Future<Either> call(GetProductDetailParams params) async {
    return await _productRepository.getProductDetail(params);
  }
}

class GetProductDetailParams {
  final String productId;

  GetProductDetailParams(this.productId);
}
