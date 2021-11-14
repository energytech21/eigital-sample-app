import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterEvent {}

class UserRegisterEvent extends RegisterEvent {
  final String email;
  final String password;
  UserRegisterEvent(this.email, this.password);
}