part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoaded extends AuthState {
  final UserEntity user;
  final String? token;

  const AuthLoaded({required this.user, this.token});

  AuthLoaded copyWith({UserEntity? user, String? token}) =>
      AuthLoaded(user: user ?? this.user, token: token ?? this.token);

  @override
  List<Object?> get props => [user, token];
}

final class Authenticated extends AuthState {
  final UserEntity user;
  final String? token;

  const Authenticated({required this.user, this.token});

  Authenticated copyWith({UserEntity? user, String? token}) =>
      Authenticated(user: user ?? this.user, token: token ?? this.token);

  @override
  List<Object?> get props => [];
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStatus {
  static const authenticated = 'authenticated';
  static const unAuthenticated = 'unAuthenticated';
}
