// screens/authntication/_buildTextField.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/mob_size.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String imagePath;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    this.controller,
    this.validator,
    super.key,
    required this.hintText,
    required this.imagePath,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPasswordHidden;

  @override
  void initState() {
    super.initState();
    isPasswordHidden = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    final double height = context.height;

    return SizedBox(
      width: width,
      height: height * 0.065,

      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: isPasswordHidden,
        keyboardType: widget.keyboardType,

        style:AppTextStyels.White16regular,
        

        decoration: InputDecoration(
          hintText: widget.hintText,

          hintStyle: AppTextStyels.White16regular,

          // ================= PREFIX ICON =================

          prefixIcon: Padding(
            padding: EdgeInsets.all(width * 0.032),

            child: SvgPicture.asset(
              widget.imagePath,
              width: width * 0.053,
              height: width * 0.053,
            ),
          ),

          // ================= PASSWORD ICON =================

          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },

                  icon: Icon(
                    isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,

                    color: AppColors.whiteColor,
                    size: width * 0.059,
                  ),
                )
              : null,

          // ================= COLORS =================

          filled: true,
          fillColor: AppColors.darkGrey,

          // ================= BORDER =================

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}