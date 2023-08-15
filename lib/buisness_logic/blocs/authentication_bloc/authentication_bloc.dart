import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    bool checkIfUserIsLoggedIn() {
      return _firebaseAuth.currentUser != null;
    }

    on<AppStarted>((event, emit) {
      final bool isUserLoggedIn = checkIfUserIsLoggedIn();
      if (isUserLoggedIn) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFailure());
      }
    });

    on<LoginWithGooglePressed>((event, emit) async {
      emit(AuthenticationInProgress());
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(credential);
          final User? user = userCredential.user;
          if (user != null) {
            emit(AuthenticationSuccess());
          } else {
            emit(AuthenticationFailure());
          }
        } else {
          emit(AuthenticationFailure());
        }
      } catch (error) {
        emit(AuthenticationFailure());
      }
    });

    on<LoggedOut>((event, emit) {
      emit(AuthenticationFailure());
    });
  }
}
