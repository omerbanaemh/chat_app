part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String email;
  LoginSuccess(this.email);
}
final class RegisterSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

final class AuthLoggedOut extends AuthState {}