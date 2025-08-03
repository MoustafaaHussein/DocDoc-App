import 'package:docdoc_app/features/Login/Data/Model/LoginModel.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel loginData;

  LoginSuccess(this.loginData);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
