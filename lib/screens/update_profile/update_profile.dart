// screens/update_profile/update_profile.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/lists/lists.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import 'package:movies_app/screens/authntication/_buildTextField.dart';
import 'package:movies_app/screens/update_profile/update_profile_cubit.dart';
import 'package:movies_app/screens/update_profile/update_profile_state.dart';
import 'package:movies_app/screens/widgets/custom_app_bar.dart';
import 'package:movies_app/screens/widgets/custom_elevated_button.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {


  final List<String> gamers = Lists.gamers;

  int selectedIndex = 0;


  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();



  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();



  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // FIND AVATAR INDEX

  int getAvatarIndex(String avatar) {
    final int index = gamers.indexOf(avatar);

    if (index == -1) {
      return 0;
    }

    return index;
  }

  

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    final double height = context.height;

    return Scaffold(
      backgroundColor: AppColors.blackColor,

      // APP BAR

      appBar: CustomAppBar.CustomApp(
        context.tr("pick_avatar"),
        context,
      ),



      body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
    

          if (state is UpdateProfileLoadedState) {
            nameController.text = state.name;
            phoneController.text = state.phone;

            final int avatarIndex =
                getAvatarIndex(state.avatar);

            setState(() {
              selectedIndex = avatarIndex;
            });
          }

          // UPDATE SUCCESS

          else if (state is UpdateProfileUpdateSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Profile updated successfully!',
                ),
                backgroundColor: Colors.green,
              ),
            );
          }

          // RESET PASSWORD SUCCESS

          else if (
              state is UpdateProfileResetPasswordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Reset password link sent to your email.',
                ),
                backgroundColor: Colors.green,
              ),
            );
          }

          // DELETE SUCCESS

          else if (state is UpdateProfileDeleteSuccessState) {
            // Go directly to Login after successful deletion.
            Navigator.pushNamedAndRemoveUntil(
              context,
              'Login_Screen',
              (route) => false,
            );
          }

          
          // ERROR

          else if (state is UpdateProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },

        

        builder: (context, state) {

          if (state is UpdateProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

      

          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.04,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: height * 0.02,
                  children: [
                    

                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:
                              AppColors.darkGrey,
                          builder: (bottomSheetContext) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: height * 0.02,
                              ),
                              child: Column(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing:
                                          width * 0.04,
                                      mainAxisSpacing:
                                          height * 0.02,
                                    ),
                                    itemCount: gamers.length,
                                    itemBuilder:
                                        (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex =
                                                index;
                                          });

                                          Navigator.pop(
                                            bottomSheetContext,
                                          );
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(
                                            vertical:
                                                height * 0.01,
                                            horizontal:
                                                width * 0.02,
                                          ),
                                          decoration:
                                              BoxDecoration(
                                            color:
                                                selectedIndex ==
                                                        index
                                                    ? AppColors
                                                        .lightOrangeColor
                                                    : AppColors
                                                        .transparentColor,
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                              20,
                                            ),
                                            border: 
                                                Border.all(
                                              color: AppColors
                                                  .primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: Image.asset(
                                              gamers[index],
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Icon(
                                                  Icons.error,
                                                  color:
                                                      Colors.red,
                                                  size: width *
                                                      0.06,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: ClipOval(
                        child: Image.asset(
                          gamers[selectedIndex],
                          height: height * 0.15,
                          width: height * 0.15,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Icon(
                              Icons.error,
                              color: Colors.red,
                              size: width * 0.06,
                            );
                          },
                        ),
                      ),
                    ),

                    // NAME

                    CustomTextField(
                      controller: nameController,
                      hintText: 'John Safwat',
                      imagePath: AppAssets.userProf,
                    ),

                    // PHONE

                    CustomTextField(
                      controller: phoneController,
                      hintText: '01200000000',
                      imagePath: AppAssets.phoneIcon,
                      keyboardType: TextInputType.phone,
                    ),

                    // RESET PASSWORD

                    GestureDetector(
                      onTap: () {
                        context
                            .read<UpdateProfileCubit>()
                            .resetPassword();
                      },
                      child: SizedBox(
                        width: width,
                        child: Text(
                          context.tr(
                            'reset_password',
                          ),
                          style: AppTextStyels
                              .White20regular,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                  

                    SizedBox(
                      height: height * 0.25,
                    ),

                    // DELETE ACCOUNT

                    state is UpdateProfileDeletingState
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : CustomElevatedButton(
                            text: context.tr(
                              "delete_account",
                            ),
                            func: () {
                              showDeleteConfirmation(
                                context,
                              );
                            },
                            color: AppColors.redColor,
                            textStyle:
                                AppTextStyels.White20regular,
                          ),

                    // UPDATE DATA

                    state is UpdateProfileUpdatingState
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : CustomElevatedButton(
                            text: context.tr(
                              "update_data",
                            ),
                            func: () {
                              if (_formKey.currentState!
                                  .validate()) {
                                context
                                    .read<
                                        UpdateProfileCubit>()
                                    .updateUserData(
                                      name:
                                          nameController.text,
                                      phone:
                                          phoneController.text,
                                      avatar:
                                          gamers[selectedIndex],
                                    );
                              }
                            },
                            color:
                                AppColors.primaryColor,
                            textStyle:
                                AppTextStyels.black20regular,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // DELETE CONFIRMATION

  void showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.darkGrey,

          title: Text(
            'Delete Account',
            style: AppTextStyels.White20regular,
          ),

          content: Text(
            'Are you sure you want to delete your account?',
            style: AppTextStyels.White16regular,
          ),

          actions: [
            // CANCEL

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: AppTextStyels.primary16regular,
              ),
            ),

            // DELETE

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                // Open password dialog.
                showPasswordDialog(context);
              },
              child: Text(
                'Delete',
                style: AppTextStyels.orange14black,
              ),
            ),
          ],
        );
      },
    );
  }

  // PASSWORD DIALOG

  void showPasswordDialog(BuildContext context) {
    final TextEditingController passwordController =
        TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.darkGrey,

          title: Text(
            'Enter Password',
            style: AppTextStyels.White20regular,
          ),

          content: TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),

          actions: [
            // CANCEL

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: AppTextStyels.primary16regular,
              ),
            ),

            // DELETE

            TextButton(
              onPressed: () async {
                final String password =
                    passwordController.text.trim();

                if (password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter your password',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Close password dialog.
                Navigator.pop(dialogContext);


                // Delete account after re-authentication.
                await context
                    .read<UpdateProfileCubit>()
                    .deleteAccount(
                      password: password,
                    );
              },
              child: Text(
                'Delete',
                style: AppTextStyels.orange14black,
              ),
            ),
          ],
        );
      },
    );
  }
}