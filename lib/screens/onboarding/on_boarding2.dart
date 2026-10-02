import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/on_boarding_model.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_routs.dart';
import 'package:movies_app/core/utils/lists/on_boarding_list.dart';
import 'package:movies_app/screens/widgets/custom_elevated_button.dart';

import '../../core/utils/app_text_styels.dart';
import '../../core/utils/mob_size.dart';

class OnBoarding2 extends StatefulWidget {
   OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  List<OnBoardingModel> onBoarding = OnBoardingList.onBoardingList;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;

    return Scaffold(

      body: Stack(
        children: [
          Image.asset(onBoarding[selectedIndex].image1, width: width,height: height*0.8,fit: BoxFit.fill,gaplessPlayback: true,),
          Image.asset(onBoarding[selectedIndex].image2, width: width,height: height*0.8,fit: BoxFit.fill,gaplessPlayback: true),

          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width,
                  padding: EdgeInsetsGeometry.symmetric(vertical: height*0.02, horizontal: width*0.02),


                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                    color: AppColors.blackColor,

                  ),
                  child: Column(
                    spacing: height*0.02,
                    children: [

                      Text(context.tr(onBoarding[selectedIndex].title), style: AppTextStyels.white24bold,textAlign: TextAlign.center,),
                      if(onBoarding[selectedIndex].body!='')Text(context.tr(onBoarding[selectedIndex].body), style: AppTextStyels.White20regular,textAlign: TextAlign.center,),
                      CustomElevatedButton(textStyle: AppTextStyels.black20semi,color: AppColors.primaryColor,text: !onBoarding[selectedIndex].isFinish? "next" :"finish",
                          func: !onBoarding[selectedIndex].isFinish? NextFunc :finishFunc),
                      if(!onBoarding[selectedIndex].isStart)
                        CustomElevatedButton(text: "back",
                          func: BackFunc, color: AppColors.blackColor, textStyle:AppTextStyels.orange20semi ,),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),

    );
  }

   void NextFunc(){
     selectedIndex++;
     setState(() {

     });
   }

   void BackFunc(){
     selectedIndex--;
     setState(() {

     });
   }

   void finishFunc(){
     Navigator.pushReplacementNamed(context,AppRouts.loginRouteName);

   }
}
