import 'package:shop_app/models/login/login_model.dart';

abstract class AuthenticationStates {}

class InitialAuthenticationState extends AuthenticationStates {}

class AuthenticationLoginLoadingState extends AuthenticationStates {}

class AuthenticationLoginSuccessState extends AuthenticationStates {
  final LoginModel model;

  AuthenticationLoginSuccessState({required this.model});
}

class AuthenticationLoginErrorState extends AuthenticationStates {
  final String error;

  AuthenticationLoginErrorState({required this.error});
}

class AuthenticationRegisterLoadingState extends AuthenticationStates {}

class AuthenticationRegisterSuccessState extends AuthenticationStates {
  final LoginModel model;

  AuthenticationRegisterSuccessState({required this.model});
}

class AuthenticationRegisterErrorState extends AuthenticationStates {
  final String error;

  AuthenticationRegisterErrorState({required this.error});
}

class AuthenticationChangePasswordVisibility extends AuthenticationStates {}
