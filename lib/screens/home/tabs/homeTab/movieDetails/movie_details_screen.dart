import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/screens/home/tabs/homeTab/movieDetails/Movie_response.dart';

class MovieDetailsScreen extends StatelessWidget {

   MovieDetailsScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(

      backgroundColor: AppColors.blackColor,
      body: MovieResponse(movieId: movieId),
    );
  }
}
