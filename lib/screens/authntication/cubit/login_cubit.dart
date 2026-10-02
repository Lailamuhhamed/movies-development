import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  final FirebaseAuth auth = FirebaseAuth.instance;


  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred, please try again';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email address';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid email or password';
      } else if (e.code == 'network-request-failed') {
        message = 'Please check your internet connection';
      }
      emit(LoginErrorState(message));
    } catch (e) {
      emit(LoginErrorState('An unexpected error occurred'));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoadingState());
    try {

      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {

        emit(LoginInitialState());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.message ?? 'Firebase Auth Error'));
    } on PlatformException catch(e){
      emit(LoginErrorState( 'Login Error'));

    }
    catch (e) {
      emit(LoginErrorState('Google Sign-In failed. Please try again.'));
    }
  }
}