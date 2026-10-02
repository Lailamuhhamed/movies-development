import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/movie_model/Movies.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import 'movie_card.dart';

class GenreSectionItem extends StatelessWidget {
  final String genreName;
  final List<Movies> allMovies;
  final VoidCallback? onSeeMoreTap;

  const GenreSectionItem({
    super.key,
    required this.genreName,
    required this.allMovies,
    this.onSeeMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final genreMovies = allMovies.where((movie) {
      if (movie.genres == null) return false;
      return movie.genres!.any(
            (g) => g.toLowerCase().trim() == genreName.toLowerCase().trim(),
      );
    }).toList();

    if (genreMovies.isEmpty) return  SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.04,
            vertical: context.height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(genreName, style: AppTextStyels.White20regular),
              InkWell(

                onTap: onSeeMoreTap,
                child: Row(
                  children: [
                    Text(
                      context.tr('see_more'),
                      style: AppTextStyels.primary16regular,
                    ),
                    SizedBox(width: context.width * 0.01),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.primaryColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.height * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: context.width * 0.04),
            itemCount: genreMovies.length,
            itemBuilder: (context, index) {
              return MovieCard(
                movie: genreMovies[index],
                width: context.width * 0.35,
                height: context.height * 0.23,
              );
            },
          ),
        ),
        SizedBox(height: context.height * 0.02),
      ],
    );
  }
}