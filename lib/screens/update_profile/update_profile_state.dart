// screens/update_profile/update_profile_state.dart

abstract class UpdateProfileState {}

// Initial state
class UpdateProfileInitialState extends UpdateProfileState {}

// Loading user data
class UpdateProfileLoadingState extends UpdateProfileState {}

// User data loaded successfully
class UpdateProfileLoadedState extends UpdateProfileState {
  final String name;
  final String phone;
  final String avatar;

  UpdateProfileLoadedState({
    required this.name,
    required this.phone,
    required this.avatar,
  });
}

// Updating user data
class UpdateProfileUpdatingState extends UpdateProfileState {}

// User data updated successfully
class UpdateProfileUpdateSuccessState extends UpdateProfileState {}

// Password reset email sent successfully
class UpdateProfileResetPasswordSuccessState
    extends UpdateProfileState {}

// Deleting account
class UpdateProfileDeletingState extends UpdateProfileState {}

// Account deleted successfully
class UpdateProfileDeleteSuccessState extends UpdateProfileState {}

// Error state
class UpdateProfileErrorState extends UpdateProfileState {
  final String errorMessage;

  UpdateProfileErrorState(this.errorMessage);
}