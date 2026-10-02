import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';

class AppTheme {

  static ThemeData DarkMode = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    iconTheme: IconThemeData(
      color: AppColors.whiteColor
    )

  );
}