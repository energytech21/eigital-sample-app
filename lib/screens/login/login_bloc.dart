import 'package:eigital_sample_app/screens/login/login_event.dart';
import 'package:eigital_sample_app/screens/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<UserLoginEvent>(_login);
  }

  Future<void> _login(UserLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      if (credential.user != null) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('Something happened on the registration'));
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
