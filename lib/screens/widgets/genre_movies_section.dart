import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/movie_model/Movies.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import 'movie_card.dart';

class GenreMoviesSection extends StatelessWidget {
  final String genreName;
  final List<Movies> movies;

  const GenreMoviesSection({
    super.key,
    required this.genreName,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.04,
            vertical: context.height * 0.015,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                genreName,
                style: AppTextStyels.White20regular
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
                size: 16,
              ),
            ],
          ),
        ),

        SizedBox(
          height: context.height * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics:  BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: context.width * 0.04),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(
                  width:context.width*0.5,
                  height: context.height * 0.23,
                  movie: movies[index]);
            },
          ),
        ),
      ],
    );
  }
}