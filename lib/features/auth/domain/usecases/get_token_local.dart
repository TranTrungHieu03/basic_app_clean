import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/auth/domain/repositories/auth_repository.dart';

class GetTokenLocalUseCase implements UseCase<Either, NoParams> {
  final AuthRepository _authRepository;

  GetTokenLocalUseCase(this._authRepository);

  @override
  Future<Either> call(NoParams params) async {
    return await _authRepository.getTokenLocal();
  }
}
