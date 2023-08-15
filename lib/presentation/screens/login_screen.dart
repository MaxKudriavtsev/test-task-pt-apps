import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_state.dart';
import 'package:test_task_pt_appps/presentation/screens/home_screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Auth error')));
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(LoginWithGooglePressed());
                },
                child: Text("enter via google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
