import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor,),
    );
  }
}