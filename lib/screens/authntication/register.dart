// screens/authntication/register.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/app_validators.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import 'package:movies_app/screens/authntication/_buildTextField.dart';
import 'package:movies_app/screens/authntication/cubit/register_cubit.dart';
import 'package:movies_app/screens/authntication/cubit/register_state.dart';
import 'package:movies_app/screens/widgets/custom_app_bar.dart';
import 'package:movies_app/screens/widgets/custom_elevated_button.dart';

import '../../core/utils/app_routs.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // ================= SELECTED DATA =================

  int selectedIndex = 0;
  int selectedFlag = 0;

  // ================= FORM =================

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ================= CONTROLLERS =================

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  // ================= AVATARS =================

  final List<String> avatars = [
    AppAssets.gamer1,
    AppAssets.gamer3,
    AppAssets.gamer2,
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  // ================= CONFIRM PASSWORD =================

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    final double height = context.height;

    return BlocProvider(
      create: (context) => RegisterCubit(),

      child: Scaffold(
        backgroundColor: AppColors.blackColor,

        appBar: CustomAppBar.CustomApp(
          context.tr("register"),
          context,
        ),

        body: SafeArea(
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {

              // ================= SUCCESS =================

              if (state is RegisterSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Account created successfully! Please login.',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );

                // Go to Login after successful registration
                Navigator.pushReplacementNamed(
                  context,
                  AppRouts.loginRouteName,
                );
              }

              // ================= ERROR =================

              else if (state is RegisterErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },

            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.043,
                  ),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [

                        SizedBox(
                          height: height * 0.012,
                        ),

                        // ================= AVATARS =================

                        SizedBox(
                          width: width,
                          height: height * 0.15,

                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,

                            children: List.generate(
                              avatars.length,
                              (index) {
                                final bool isSelected =
                                    selectedIndex == index;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },

                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 250,
                                    ),

                                    curve: Curves.easeInOut,

                                    width: isSelected
                                        ? width * 0.30
                                        : width * 0.235,

                                    height: isSelected
                                        ? width * 0.30
                                        : width * 0.235,

                                    decoration:
                                        const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),

                                    child: ClipOval(
                                      child: Image.asset(
                                        avatars[index],
                                        fit: BoxFit.cover,

                                        errorBuilder:
                                            (
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
                                );
                              },
                            ),
                          ),
                        ),

                        // ================= AVATAR TEXT =================

                        Text(
                          context.tr("avatar"),
                          style:
                              AppTextStyels.White16regular,
                        ),

                        SizedBox(
                          height: height * 0.010,
                        ),

                        // ================= NAME =================

                        CustomTextField(
                          controller: nameController,
                          hintText: context.tr("name"),
                          imagePath: AppAssets.nameIcon,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter your name';
                            }

                            return null;
                          },
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        // ================= EMAIL =================

                        CustomTextField(
                          controller: emailController,
                          hintText: context.tr("email"),
                          imagePath: AppAssets.emailIcon,
                          keyboardType:
                              TextInputType.emailAddress,
                          validator:
                              AppValidators.validateEmail,
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        // ================= PASSWORD =================

                        CustomTextField(
                          controller: passwordController,
                          hintText: context.tr("password"),
                          imagePath: AppAssets.passwordIcon,
                          obscureText: true,
                          validator:
                              AppValidators.validatePassword,
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        // ================= CONFIRM PASSWORD =================

                        CustomTextField(
                          controller:
                              confirmPasswordController,
                          hintText:
                              context.tr("confirm_password"),
                          imagePath: AppAssets.passwordIcon,
                          obscureText: true,
                          validator:
                              validateConfirmPassword,
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        // ================= PHONE =================

                        CustomTextField(
                          controller: phoneController,
                          hintText:
                              context.tr("phone_number"),
                          imagePath: AppAssets.phoneIcon,
                          keyboardType:
                              TextInputType.phone,

                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter your phone number';
                            }

                            return null;
                          },
                        ),

                        SizedBox(
                          height: height * 0.025,
                        ),

                        // ================= CREATE ACCOUNT =================

                        state is RegisterLoadingState

                            ? const CircularProgressIndicator(
                                color:
                                    AppColors.primaryColor,
                              )

                            : SizedBox(
                                width: width,
                                height: height * 0.065,

                                child:
                                    CustomElevatedButton(
                                  text: context.tr(
                                    "create_account",
                                  ),

                                  func: () {
                                    if (_formKey
                                        .currentState!
                                        .validate()) {

                                      context
                                          .read<
                                              RegisterCubit>()
                                          .registerUser(
                                            name:
                                                nameController
                                                    .text,

                                            email:
                                                emailController
                                                    .text,

                                            password:
                                                passwordController
                                                    .text,

                                            phone:
                                                phoneController
                                                    .text,

                                            avatar:
                                                avatars[
                                                    selectedIndex],

                                            country:
                                                selectedFlag ==
                                                        0
                                                    ? 'USA'
                                                    : 'Egypt',
                                          );
                                    }
                                  },

                                  color:
                                      AppColors.primaryColor,

                                  textStyle:
                                      AppTextStyels
                                          .black20semi,
                                ),
                              ),

                        SizedBox(
                          height: height * 0.020,
                        ),

                        // ================= LOGIN =================

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [

                            Flexible(
                              child: Text(
                                context.tr(
                                  "already_have_account",
                                ),

                                textAlign:
                                    TextAlign.center,

                                style:
                                    AppTextStyels
                                        .White14regular,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouts.loginRouteName,
                                );
                              },

                              child: Text(
                                context.tr("login"),

                                style:
                                    AppTextStyels
                                        .orange14black,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: height * 0.012,
                        ),

                        // ================= FLAGS =================

                        Container(
                          height: height * 0.050,

                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.010,
                          ),

                          decoration: BoxDecoration(
                            color: AppColors.blackColor,

                            border: Border.all(
                              color:
                                  AppColors.primaryColor,
                              width: 2,
                            ),

                            borderRadius:
                                BorderRadius.circular(30),
                          ),

                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min,

                            children: [

                              // ================= USA =================

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFlag = 0;
                                  });
                                },

                                child: Container(
                                  width: width * 0.09,
                                  height: width * 0.09,

                                  decoration:
                                      BoxDecoration(
                                    shape:
                                        BoxShape.circle,

                                    border: Border.all(
                                      color: selectedFlag ==
                                              0
                                          ? AppColors
                                              .primaryColor
                                          : Colors
                                              .transparent,

                                      width: 4,
                                    ),
                                  ),

                                  child: ClipOval(
                                    child:
                                        SvgPicture.asset(
                                      AppAssets.usaFlag,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: width * 0.03,
                              ),

                              // ================= EGYPT =================

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFlag = 1;
                                  });
                                },

                                child: Container(
                                  width: width * 0.09,
                                  height: width * 0.09,

                                  decoration:
                                      BoxDecoration(
                                    shape:
                                        BoxShape.circle,

                                    border: Border.all(
                                      color: selectedFlag ==
                                              1
                                          ? AppColors
                                              .primaryColor
                                          : Colors
                                              .transparent,

                                      width: 4,
                                    ),
                                  ),

                                  child: ClipOval(
                                    child:
                                        SvgPicture.asset(
                                      AppAssets.egyptFlag,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}