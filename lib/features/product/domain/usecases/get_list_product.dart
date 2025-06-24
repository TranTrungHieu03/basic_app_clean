import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/product/domain/repositories/product_repository.dart';

class GetListProductUseCase implements UseCase<Either, GetListProductDto> {
  final ProductRepository _productRepository;

  GetListProductUseCase(this._productRepository);

  @override
  Future<Either> call(GetListProductDto params) async {
    return await _productRepository.getListProducts(params);
  }
}

class GetListProductDto {
  final int limit;
  final int page;
  final bool isFirstRender;

  GetListProductDto({
    required this.limit,
    required this.page,
    this.isFirstRender = true,
  });

  Map<String, dynamic> toJson() => {
    'limit': limit,
    'skip': (page - 1 > 0 ? page - 1 : 0) * limit,
  };
}
