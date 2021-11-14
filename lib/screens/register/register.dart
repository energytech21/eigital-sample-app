import 'package:eigital_sample_app/screens/register/register_bloc.dart';
import 'package:eigital_sample_app/screens/register/register_event.dart';
import 'package:eigital_sample_app/screens/register/register_state.dart';
import 'package:eigital_sample_app/shared/mixins/listenToStateChangeMixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget with ListenToStateChangeMixin<RegisterState>   {
  final _emailFieldController = new TextEditingController();
  final _passwordFieldController = new TextEditingController();

  RegisterScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: BlocListener<RegisterBloc,RegisterState>(
        listener: listenStateChange,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                TextFormField(
                  controller: _emailFieldController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address'
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordFieldController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password'
                  ),
                  obscureText: true,
                ),
                MaterialButton(
                  onPressed: () {
                    context.read<RegisterBloc>().add(UserRegisterEvent(_emailFieldController.text,_passwordFieldController.text));
                  },
                  child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 15)),
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void listenStateChange(BuildContext ctx,RegisterState state) {
    if(state is RegisterLoadingState){
      showDialog(context: ctx, builder: (ctx) => AlertDialog(
        title: Text('Register'),
        content: Text('Registering user...'),
      ));
    }
    if(state is RegisterSuccessState){
      Navigator.of(ctx).popUntil((route) => route.settings.name == '/'); 
    }
    if(state is RegisterErrorState){
      //we are not pushing any routes in this navigator, so this will dismiss any dialogs are currently present on the navigator
      Navigator.of(ctx).popUntil((route) => route.settings.name == '/register'); 
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

}