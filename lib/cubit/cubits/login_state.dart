part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginSucces extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginFailure extends LoginState {
  String errormessage;
  LoginFailure({required this.errormessage});
}