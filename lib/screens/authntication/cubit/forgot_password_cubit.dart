import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail(String email) async {
    emit(ForgotPasswordLoadingState());
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      emit(ForgotPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred, please try again';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email address';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address';
      } else if (e.code == 'network-request-failed') {
        message = 'Please check your internet connection';
      }
      emit(ForgotPasswordErrorState(message));
    } catch (e) {
      emit(ForgotPasswordErrorState('An unexpected error occurred'));
    }
  }
}