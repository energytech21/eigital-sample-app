import 'package:eigital_sample_app/screens/login/login_bloc.dart';
import 'package:eigital_sample_app/screens/login/login_event.dart';
import 'package:eigital_sample_app/screens/login/login_state.dart';
import 'package:eigital_sample_app/shared/mixins/listenToStateChangeMixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ListenToStateChangeMixin<LoginState>  {
  final _emailFieldController = new TextEditingController(text: "brianamande@gmail.com");

  final _passwordFieldController = new TextEditingController(text: "brian1014");
  @override
  void initState() {
    super.initState();

    Location.instance.hasPermission().then((value) {
      if(value == PermissionStatus.denied || value == PermissionStatus.deniedForever){
        Location.instance.requestPermission().then((value) {
          //Location is a requirement so we close the app once the app is denied from the permission
          if(value == PermissionStatus.denied || value == PermissionStatus.deniedForever) {
            SystemNavigator.pop();
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc,LoginState>(
        listener: listenStateChange,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text('Welcome!',style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold))),
              SizedBox(height: 10),
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
                child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 15)),
                onPressed: () {
                  context.read<LoginBloc>().add(UserLoginEvent(_emailFieldController.text,_passwordFieldController.text));
                },
                color: Theme.of(context).primaryColor),
              MaterialButton(
                onPressed: () => Navigator.of(context).pushNamed('/register'),
                child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 15)),
                color: Theme.of(context).primaryColor)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void listenStateChange(BuildContext ctx,LoginState state) {
    if(state is LoginLoadingState){
      showDialog(context: ctx, builder: (ctx) => AlertDialog(
        title: Text('Login'),
        content: Text('Logging in user...'),
      ));
    }
    if(state is LoginSuccessState){
      Navigator.of(ctx).popUntil((route) => route.settings.name == '/'); 
      Navigator.of(ctx).pushReplacementNamed('/home'); 
    }
    if(state is LoginErrorState){
      //we are not pushing any routes in this navigator, so this will dismiss any dialogs are currently present on the navigator
      Navigator.of(ctx).popUntil((route) => route.settings.name == '/'); 
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }
}