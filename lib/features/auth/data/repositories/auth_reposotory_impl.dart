import 'package:dartz/dartz.dart';
import 'package:store_demo/core/errors/exceptions.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:store_demo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:store_demo/features/auth/data/models/user_model.dart';
import 'package:store_demo/features/auth/domain/entities/user_entity.dart';
import 'package:store_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:store_demo/features/auth/domain/usecases/login_usecase.dart';
import 'package:store_demo/features/auth/domain/usecases/refresh_token.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(LoginDto params) async {
    try {
      final data = await _authRemoteDataSource.login(params);
      await _authLocalDataSource.saveUserInformation(UserModel.serialize(data));
      await _authLocalDataSource.saveToken(data.accessToken);
      await _authLocalDataSource.saveRefreshToken(data.refreshToken);
      return right(data.toEntity());
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getTokenLocal() async {
    try {
      final data = await _authLocalDataSource.getToken();
      return right(data);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserLocal() async {
    try {
      final data = await _authLocalDataSource.getUserInformation();
      return right(data.toEntity());
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserInformation() async {
    try {
      final data = await _authRemoteDataSource.getUserInformation();
      await _authLocalDataSource.saveUserInformation(UserModel.serialize(data));
      // await _authLocalDataSource.saveToken(data.accessToken);
      return right(data.toEntity());
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RefreshTokenResponse>> refreshToken() async {
    try {
      final dataLocal = await _authLocalDataSource.getUserInformation();
      final data = await _authRemoteDataSource.refreshToken(
        RefreshTokenDto(refreshToken: dataLocal.refreshToken),
      );
      return right(data);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
