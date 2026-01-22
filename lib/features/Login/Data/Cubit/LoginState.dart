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

class DeleteAccountSuccess extends LoginState {
  final String message;

  DeleteAccountSuccess(this.message);
}

class DeleteAccountFailure extends LoginState {
  final String message;

  DeleteAccountFailure(this.message);
}
