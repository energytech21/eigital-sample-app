import 'package:eigital_sample_app/screens/home/home.dart';
import 'package:eigital_sample_app/screens/home/home_bloc.dart';
import 'package:eigital_sample_app/screens/login/login.dart';
import 'package:eigital_sample_app/screens/login/login_bloc.dart';
import 'package:eigital_sample_app/screens/register/register.dart';
import 'package:eigital_sample_app/screens/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eigital Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (ctx) => BlocProvider<LoginBloc>(
            create: (ctx) => LoginBloc(), child: LoginScreen()),
        "/register": (ctx) => BlocProvider<RegisterBloc>(
            create: (ctx) => RegisterBloc(), child: RegisterScreen()),
        "/home": (ctx) => BlocProvider<HomeBloc>(
            create: (ctx) => HomeBloc(), child: HomeScreen()),
      },
    );
  }
}
