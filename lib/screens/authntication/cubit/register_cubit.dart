// screens/authntication/cubit/register_cubit.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String avatar,
    required String country,
  }) async {
    emit(RegisterLoadingState());

    try {
      // ================= CREATE AUTH ACCOUNT =================

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // ================= GET USER =================

      final User? user = userCredential.user;

      if (user == null) {
        emit(
          RegisterErrorState(
            'Could not create user account',
          ),
        );
        return;
      }

      // ================= SAVE USER DATA =================

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'avatar': avatar,
        'country': country,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // ================= SUCCESS =================

      emit(RegisterSuccessState());

    } on FirebaseAuthException catch (e) {
      String message =
          'An error occurred, please try again';

      if (e.code == 'email-already-in-use') {
        message =
            'This email is already registered';
      } else if (e.code == 'invalid-email') {
        message =
            'Please enter a valid email address';
      } else if (e.code == 'weak-password') {
        message =
            'Password is too weak';
      } else if (e.code == 'network-request-failed') {
        message =
            'Please check your internet connection';
      }

      emit(RegisterErrorState(message));

    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        emit(
          RegisterErrorState(
            'You do not have permission to save user data',
          ),
        );
      } else {
        emit(
          RegisterErrorState(
            'Could not save user data',
          ),
        );
      }

    } catch (e) {
      emit(
        RegisterErrorState(
          'An unexpected error occurred',
        ),
      );
    }
  }
}