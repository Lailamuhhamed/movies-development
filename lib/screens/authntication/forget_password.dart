import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/mob_size.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '_buildTextField.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
   final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
 // gadsaif91@gmail.com
  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;

    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: CustomAppBar.CustomApp(
          context.tr('forget_password_appBar'),
          context,
        ),
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reset link sent , Please check your email inbox.'),
                  backgroundColor: Colors.green,
                ),
              );
            } 

            else if (state is ForgotPasswordErrorState) {
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ------image ----
                    Image.asset(AppAssets.forgetPassword),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Column(
                        spacing: height * 0.02,
                        children: [
                          //--------- text field -----
                          CustomTextField(
                            controller: emailController,
                            hintText: context.tr('email'),
                            imagePath: AppAssets.emailIcon,
                          ),
                          // -----button Verify Email ----
                          state is ForgotPasswordLoadingState
                              ? const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : CustomElevatedButton(
                                  text: context.tr('verify_email'),
                                  func: () {
                                    // todo verify Email action
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<ForgotPasswordCubit>()
                                          .sendPasswordResetEmail(
                                            emailController.text,
                                          );
                                    }
                                  },
                                  color: AppColors.primaryColor,
                                  textStyle: AppTextStyels.black20regular,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}