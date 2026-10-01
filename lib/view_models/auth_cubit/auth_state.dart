part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthChecking extends AuthState {
  const AuthChecking();
}

final class AuthDone extends AuthState {
  const AuthDone();
}

final class AuthFailed extends AuthState {
  final String message;
  const AuthFailed({required this.message});
}

final class AuthLoggedout extends AuthState {
  const AuthLoggedout();
}

final class AuthLoggingOut extends AuthState {
  const AuthLoggingOut();
}

final class AuthLoggingOutFailed extends AuthState {
  final String message;
  AuthLoggingOutFailed({required this.message});
}


final class GoogleAuthinticating extends AuthState {
  const GoogleAuthinticating();
}

final class GoogleAuthDone extends AuthState {
  const GoogleAuthDone();
}

final class GoogleAuthFailed extends AuthState {
  final String message;
  GoogleAuthFailed({required this.message});
}
