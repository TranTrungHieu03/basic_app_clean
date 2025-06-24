import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<Either, LoginDto> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either> call(LoginDto params) async {
    return await _authRepository.login(params);
  }
}

class LoginDto {
  final String username;
  final String password;

  LoginDto({required this.password, required this.username});

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }
}
