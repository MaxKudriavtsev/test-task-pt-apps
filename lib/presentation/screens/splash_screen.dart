import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_state.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/splash_cat.png',
          ),
        ),
      ),
    );
  }
}
