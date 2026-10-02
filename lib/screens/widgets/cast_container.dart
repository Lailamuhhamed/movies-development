import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/movie_details/Cast.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/screens/widgets/ScreenShot_image.dart';

import '../../core/utils/mob_size.dart';

class CastContainer extends StatelessWidget {
  Cast actor;
   CastContainer({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12),
        color: AppColors.darkGrey,

      ),
      padding: EdgeInsetsGeometry.symmetric(vertical: height*0.01, horizontal: width*0.03),
      margin:EdgeInsetsGeometry.symmetric(vertical: height*0.01) ,
      width: width,
      child: Row(
        spacing: 8,
        children: [
         if(actor.urlSmallImage!=null)ScreenshotImage(image: actor.urlSmallImage),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: actor.urlSmallImage!=null?width*0.6:width*0.7,
                  child: Text(context.tr("name_cast")+ "${actor.name ?? ''}", style: AppTextStyels.White20regular,)),
              SizedBox(width: actor.urlSmallImage!=null?width*0.6:width*0.7,
                  child: Text(context.tr("character")+"${actor.characterName ?? ''}", style: AppTextStyels.White20regular,))
            ],
          )
        ],
      ),
    );
  }
}
