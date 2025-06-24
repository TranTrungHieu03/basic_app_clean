import 'package:dartz/dartz.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/features/auth/domain/entities/user_entity.dart';
import 'package:store_demo/features/auth/domain/usecases/login_usecase.dart';
import 'package:store_demo/features/auth/domain/usecases/refresh_token.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginDto params);

  Future<Either<Failure, String>> getTokenLocal();

  Future<Either<Failure, UserEntity>> getUserLocal();

  Future<Either<Failure, UserEntity>> getUserInformation();

  Future<Either<Failure, RefreshTokenResponse>> refreshToken();
}
