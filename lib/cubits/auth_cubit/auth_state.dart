part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
  final String email;
  RegisterSuccess(this.email);
}

final class RegisterFailure extends AuthState {
  final String errorMessage;
  RegisterFailure(this.errorMessage);
} 

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String email;
  LoginSuccess(this.email);
}

final class LoginFailure extends AuthState {
  final String errorMessage;
  LoginFailure(this.errorMessage);
}

