part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final LoginDto params;

  AuthLoginEvent(this.params);
}

final class GetTokenLocalEvent extends AuthEvent {}

final class GetUserInformationEvent extends AuthEvent {}

final class GetUserLocalEvent extends AuthEvent {}

final class RefreshTokenEvent extends AuthEvent {
}
