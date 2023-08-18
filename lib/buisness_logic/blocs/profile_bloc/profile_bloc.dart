import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthenticationBloc _authenticationBloc;

  ProfileBloc(this._authenticationBloc) : super(ProfileLoading()) {
    on<LoadProfile>((event, emit) {
      final User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        emit(ProfileLoaded(currentUser));
      } else {
        emit(ProfileError());
      }
    });

    on<Logout>((event, emit) async {
      await _firebaseAuth.signOut();
      _authenticationBloc.add(LoggedOut());
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
