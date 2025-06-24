import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/cart/domain/repositories/cart_repository.dart';

class GetCartByUserUseCase implements UseCase<Either, GetCartByUserDto> {
  final CartRepository _cartRepository;

  GetCartByUserUseCase(this._cartRepository);

  @override
  Future<Either> call(GetCartByUserDto params) async {
    return await _cartRepository.getCarts(params);
  }
}

class GetCartByUserDto {
  final String userId;

  GetCartByUserDto({required this.userId});
}
