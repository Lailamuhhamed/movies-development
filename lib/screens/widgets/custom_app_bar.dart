import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';

class CustomAppBar {

  static PreferredSizeWidget CustomApp(String title, BuildContext context){

    return AppBar(
      backgroundColor: AppColors.blackColor,
      elevation: 0,

      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.primaryColor,
          size: 21,
        ),
      ),

      title: Text(
        title,
        style: AppTextStyels.orange20semi.copyWith(
          fontSize: 14,
        ),
      ),

      centerTitle: true,
    );
  }
}
