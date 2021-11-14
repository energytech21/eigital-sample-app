

import 'package:eigital_sample_app/screens/register/register_event.dart';
import 'package:eigital_sample_app/screens/register/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  
  RegisterBloc() : super(RegisterInitialState()){
    on<UserRegisterEvent>(_register);
  }

  Future<void> _register(UserRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try{
      var credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: event.email, password: event.password);
      if(credentials.user != null){
        emit(RegisterSuccessState());
      }
      else{
        emit(RegisterErrorState('Something happened on the registration'));
      }
    }
    on FirebaseAuthException catch (e){
      emit(RegisterErrorState(e.message ?? ''));
    }
    catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}