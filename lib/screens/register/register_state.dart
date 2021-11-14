import 'package:eigital_sample_app/screens/login/login_event.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}

class RegisterLoadingState extends RegisterState {}