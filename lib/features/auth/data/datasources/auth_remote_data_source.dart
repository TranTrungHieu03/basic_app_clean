import 'package:store_demo/core/errors/exceptions.dart';
import 'package:store_demo/core/errors/failures.dart';
import 'package:store_demo/core/network/dio_api_services.dart';
import 'package:store_demo/core/response/api_response.dart';
import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/features/auth/data/models/user_model.dart';
import 'package:store_demo/features/auth/domain/usecases/login_usecase.dart';
import 'package:store_demo/features/auth/domain/usecases/refresh_token.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginDto params);

  Future<UserModel> getUserInformation();

  Future<RefreshTokenResponse> refreshToken(RefreshTokenDto params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioApiServices _apiServices;

  AuthRemoteDataSourceImpl(this._apiServices);

  @override
  Future<UserModel> login(LoginDto params) async {
    try {
      final response = await _apiServices.post("auth/login", params.toJson());
      final responseFormat = ApiResponse.fromJson(response);
      if (responseFormat.message != null) {
        throw AppException(responseFormat.message);
      }
      return UserModel.fromJson(responseFormat.data);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<UserModel> getUserInformation() async {
    try {
      final response = await _apiServices.get("auth/me", {});
      // AppLogger.info(response);
      final responseFormat = ApiResponse.fromJson(response);
      if (responseFormat.message != null) {
        throw AppException(responseFormat.message);
      }
      return UserModel.fromJson(responseFormat.data);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<RefreshTokenResponse> refreshToken(params) async {
    try {
      final response = await _apiServices.post("auth/refresh", params.toJson());
      final responseFormat = ApiResponse.fromJson(response);
      if (responseFormat.message != null) {
        throw AppException(responseFormat.message);
      }
      return RefreshTokenResponse.fromJson(responseFormat.data);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
