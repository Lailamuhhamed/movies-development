import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';

import '../../core/utils/mob_size.dart';
class CustomElevatedButton extends StatelessWidget {
  String text;
  void Function() func;
  Color color;
  TextStyle _textStyle;
  String? icon;
   CustomElevatedButton({super.key, required this.text,  required this.func,
    required this.color, required this._textStyle, this.icon});

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    return ElevatedButton(onPressed: func,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height*0.06),
          backgroundColor:color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(width * 0.04),
            side: BorderSide(
              color: color == AppColors.blackColor?AppColors.primaryColor: color,
                  width: 2,
            )
          )
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: width*0.02,
        children: [
          if(icon!=null) Image.asset(icon!),
          Text(context.tr(text), style: _textStyle,),
        ],
      ),
    );
  }
}
