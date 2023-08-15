import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_state.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_bloc.dart';
import 'package:test_task_pt_appps/firebase_options.dart';
import 'package:test_task_pt_appps/presentation/screens/home_screen.dart';
import 'package:test_task_pt_appps/presentation/screens/splash_screen.dart';

import 'buisness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'buisness_logic/blocs/authentication_bloc/authentication_event.dart';
import 'presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc..add(AppStarted()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(authenticationBloc),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return SplashScreen();
                } else if (state is AuthenticationSuccess) {
                  return HomeScreen();
                } else if (state is AuthenticationFailure) {
                  return LoginPage();
                } else {
                  return SplashScreen();
                }
              },
            );
          },
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
