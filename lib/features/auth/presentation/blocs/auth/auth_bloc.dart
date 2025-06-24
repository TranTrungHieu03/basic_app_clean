import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/features/auth/data/models/user_model.dart';
import 'package:store_demo/features/auth/domain/entities/user_entity.dart';
import 'package:store_demo/features/auth/domain/usecases/get_token_local.dart';
import 'package:store_demo/features/auth/domain/usecases/get_user_information.dart';
import 'package:store_demo/features/auth/domain/usecases/get_user_lcoal.dart';
import 'package:store_demo/features/auth/domain/usecases/login_usecase.dart';
import 'package:store_demo/features/auth/domain/usecases/refresh_token.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final GetTokenLocalUseCase _getTokenLocalUseCase;
  final GetUserLocalUseCase _getUserLocalUseCase;
  final GetUserInformationUseCase _getUserInformationUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required GetTokenLocalUseCase getTokenLocalUseCase,
    required GetUserLocalUseCase getUserLocalUseCase,
    required GetUserInformationUseCase getUserInformationUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
  }) : _loginUseCase = loginUseCase,
       _getUserLocalUseCase = getUserLocalUseCase,
       _getTokenLocalUseCase = getTokenLocalUseCase,
       _refreshTokenUseCase = refreshTokenUseCase,
       _getUserInformationUseCase = getUserInformationUseCase,
       super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await _loginUseCase.call(event.params);
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (data) => emit(AuthLoaded(user: data)),
      );
    });
    on<GetTokenLocalEvent>((event, emit) async {
      final currentState = state;
      if (currentState is AuthLoaded) {
        final result = await _getTokenLocalUseCase.call(NoParams());
        result.fold(
          (failure) => emit(AuthError(message: failure.message)),
          (data) => emit(currentState.copyWith(token: data)),
        );
      } else {
        final result = await _getTokenLocalUseCase.call(NoParams());
        result.fold(
          (failure) => emit(AuthError(message: failure.message)),
          (data) => emit(AuthLoaded(token: data, user: UserModel.isEmpty())),
        );
      }
    });
    on<GetUserLocalEvent>((event, emit) async {
      final currentState = state;
      if (currentState is AuthLoaded) {
        final result = await _getUserLocalUseCase.call(NoParams());
        result.fold(
          (failure) => emit(AuthError(message: failure.message)),
          (data) => emit(currentState.copyWith(user: data)),
        );
      } else {
        final result = await _getUserLocalUseCase.call(NoParams());
        result.fold(
          (failure) => emit(AuthError(message: failure.message)),
          (data) => emit(AuthLoaded(user: data, token: "")),
        );
      }
    });
    on<GetUserInformationEvent>((event, emit) async {
      final result = await _getUserInformationUseCase.call(NoParams());
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (data) => emit(AuthLoaded(user: data)),
      );
    });
    on<RefreshTokenEvent>((event, emit) async {
      final result = await _refreshTokenUseCase.call(NoParams());
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (data) => {},
      );
    });
  }
}
