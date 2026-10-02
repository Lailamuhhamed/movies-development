// screens/update_profile/update_profile_cubit.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitialState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // GET CURRENT USER DATA

  Future<void> getUserData() async {
    emit(UpdateProfileLoadingState());

    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        emit(
          UpdateProfileErrorState(
            'No logged-in user found',
          ),
        );
        return;
      }

      final userRef =
          _firestore.collection('users').doc(user.uid);

      final userDocument = await userRef.get();

      // If user document does not exist, create it automatically.
      if (!userDocument.exists) {
        await userRef.set({
          'name': user.displayName ?? '',
          'phone': '',
          'avatar': '',
          'email': user.email ?? '',
        });

        emit(
          UpdateProfileLoadedState(
            name: user.displayName ?? '',
            phone: '',
            avatar: '',
          ),
        );

        return;
      }

      final data = userDocument.data() ?? {};

      emit(
        UpdateProfileLoadedState(
          name: data['name'] ?? '',
          phone: data['phone'] ?? '',
          avatar: data['avatar'] ?? '',
        ),
      );
    } on FirebaseException catch (e) {
      emit(
        UpdateProfileErrorState(
          e.message ?? 'Could not load user data',
        ),
      );
    } catch (e) {
      emit(
        UpdateProfileErrorState(
          'An unexpected error occurred',
        ),
      );
    }
  }

  // UPDATE USER DATA

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(UpdateProfileUpdatingState());

    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        emit(
          UpdateProfileErrorState(
            'No logged-in user found',
          ),
        );
        return;
      }

      final String updatedName = name.trim();
      final String updatedPhone = phone.trim();

      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({
        'name': updatedName,
        'phone': updatedPhone,
        'avatar': avatar,
      });

      emit(UpdateProfileUpdateSuccessState());

      emit(
        UpdateProfileLoadedState(
          name: updatedName,
          phone: updatedPhone,
          avatar: avatar,
        ),
      );
    } on FirebaseException catch (e) {
      emit(
        UpdateProfileErrorState(
          e.message ?? 'Could not update user data',
        ),
      );
    } catch (e) {
      emit(
        UpdateProfileErrorState(
          'An unexpected error occurred',
        ),
      );
    }
  }

  // SEND PASSWORD RESET EMAIL

  Future<void> resetPassword() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null || user.email == null) {
        emit(
          UpdateProfileErrorState(
            'No logged-in user found',
          ),
        );
        return;
      }

      await _auth.sendPasswordResetEmail(
        email: user.email!,
      );

      emit(UpdateProfileResetPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(
        UpdateProfileErrorState(
          e.message ??
              'Could not send reset password email',
        ),
      );
    } catch (e) {
      emit(
        UpdateProfileErrorState(
          'An unexpected error occurred',
        ),
      );
    }
  }

  // DELETE ACCOUNT

  Future<void> deleteAccount({
    required String password,
  }) async {
    emit(UpdateProfileDeletingState());

    try {
      final User? user = _auth.currentUser;

      if (user == null || user.email == null) {
        emit(
          UpdateProfileErrorState(
            'No logged-in user found',
          ),
        );
        return;
      }

      final String uid = user.uid;

      // Create email/password credentials.
      final AuthCredential credential =
          EmailAuthProvider.credential(
        email: user.email!,
        password: password.trim(),
      );

      // Re-authenticate the user before deleting.
      await user.reauthenticateWithCredential(
        credential,
      );

      // Delete user data from Firestore.
      await _firestore
          .collection('users')
          .doc(uid)
          .delete();

      // Delete user from Firebase Authentication.
      await user.delete();

      // Notify UI that the account was deleted successfully.
      emit(UpdateProfileDeleteSuccessState());
    } on FirebaseAuthException catch (e) {
      String message = 'Could not delete account';

      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = 'Incorrect password';
      } else if (e.code == 'user-mismatch') {
        message =
            'The provided credentials do not match this account';
      } else if (e.code == 'user-not-found') {
        message = 'No user found';
      } else if (e.code == 'requires-recent-login') {
        message =
            'Please login again before deleting your account';
      } else if (e.message != null) {
        message = e.message!;
      }

      emit(
        UpdateProfileErrorState(message),
      );
    } on FirebaseException catch (e) {
      emit(
        UpdateProfileErrorState(
          e.message ?? 'Could not delete user data',
        ),
      );
    } catch (e) {
      emit(
        UpdateProfileErrorState(
          'An unexpected error occurred',
        ),
      );
    }
  }
}