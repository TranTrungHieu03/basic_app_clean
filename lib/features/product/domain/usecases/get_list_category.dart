import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/product/domain/repositories/product_repository.dart';

class GetListCategoryUseCase implements UseCase<Either, NoParams> {
  final ProductRepository _productRepository;

  GetListCategoryUseCase(this._productRepository);

  @override
  Future<Either> call(NoParams params) async {
    return await _productRepository.getListCategories();
  }
}
