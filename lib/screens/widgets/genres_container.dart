import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_text_styels.dart';
import '../../core/utils/mob_size.dart';

class GenresContainer extends StatelessWidget {
  String genres;
   GenresContainer({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12),
        color: AppColors.darkGrey,
      ),
      padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.02, vertical: height*0.01),
      child: Center(child: Text(genres, style: AppTextStyels.White16regular,)),

    );
  }
}
