import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/mob_size.dart';

class CustomContainerRate extends StatelessWidget {
  final IconData icon;
   var rate;
   CustomContainerRate({super.key, required this.icon, required this.rate});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadiusGeometry.circular(12),

      ),
      width:width*0.28 ,
      height: height*0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: width*0.02,
        children: [
          Icon(icon, color: AppColors.primaryColor,),
          Text('${rate??''}', style: AppTextStyels.white24bold,)
        ],
      ),
    );
  }
}
