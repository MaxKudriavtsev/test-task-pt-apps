import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_state.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_state.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<ProfileBloc>().add(Logout());
              },
            ),
          ],
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {}
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(state.user.photoURL!),
                    ),
                    SizedBox(height: 10),
                    Text('Name: ${state.user.displayName}'),
                    SizedBox(height: 10),
                    Text('Email: ${state.user.email}'),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text('An error occurred! Please try again.'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
