import 'package:eigital_sample_app/screens/login/login_event.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}

class LoginLoadingState extends LoginState {}