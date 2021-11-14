abstract class LoginEvent {}

class UserLoginEvent extends LoginEvent {
  final String email;
  final String password;
  UserLoginEvent(this.email, this.password);
}