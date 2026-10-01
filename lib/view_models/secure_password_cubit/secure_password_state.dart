part of 'secure_password_cubit.dart';

sealed class SecurePasswordState {}

final class SecurePasswordInitial extends SecurePasswordState {}
final class PasswordIsVisible extends SecurePasswordState{}
final class PasswordIsUnVisible extends SecurePasswordState{}

