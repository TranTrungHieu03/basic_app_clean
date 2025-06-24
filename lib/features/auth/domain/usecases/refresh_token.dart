import 'package:dartz/dartz.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase implements UseCase<Either, NoParams> {
  final AuthRepository _authRepository;

  RefreshTokenUseCase(this._authRepository);

  @override
  Future<Either> call(NoParams params) async {
    return await _authRepository.refreshToken();
  }
}

class RefreshTokenResponse {
  final String accessToken;
  final String refreshToken;

  RefreshTokenResponse({required this.accessToken, required this.refreshToken});

  RefreshTokenResponse copyWith({String? accessToken, String? refreshToken}) =>
      RefreshTokenResponse(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      RefreshTokenResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}

final class RefreshTokenDto {
  final String refreshToken;

  RefreshTokenDto({required this.refreshToken});

  Map<String, dynamic> toJson() => {"refreshToken": refreshToken};
}
