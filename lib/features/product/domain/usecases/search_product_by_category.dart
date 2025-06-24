import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/product/domain/repositories/product_repository.dart';

class SearchProductByCategory
    implements UseCase<Either, SearchProductByCategoryDto> {
  final ProductRepository _productRepository;

  SearchProductByCategory(this._productRepository);

  @override
  Future<Either> call(SearchProductByCategoryDto params) async {
    return await _productRepository.getListProductsByCategory(params);
  }
}

class SearchProductByCategoryDto {
  final String type;
  final int limit;
  final int page;

  SearchProductByCategoryDto({
    required this.type,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toJson() => {
    'limit': limit,
    'skip': (page - 1 > 0 ? page - 1 : 0) * limit,
  };
}
