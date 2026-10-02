import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';

class MainErrorWidget extends StatelessWidget {
  String errorMessage;
  VoidCallback func1;
  VoidCallback func2;
  MainErrorWidget({super.key, required this.errorMessage, required this.func1, required this.func2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Text(errorMessage, style: const TextStyle(color: Colors.red)),
        ElevatedButton(onPressed: func1,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor
          ),
          child: Text('Try Again', style: AppTextStyels.black20regular,),

        ),
        ElevatedButton(onPressed: func2,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor
          ),
          child: Text('Exit',style: AppTextStyels.black20regular,),

        )
      ],
    );
  }
}