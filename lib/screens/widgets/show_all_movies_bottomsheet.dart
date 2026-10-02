import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import '../../core/utils/Model/movie_model/Movies.dart';
import '../widgets/movie_card.dart';

class AllMoviesBottomSheet extends StatelessWidget {
  final String genreName;
  final List<Movies> allMovies;

  const AllMoviesBottomSheet({
    super.key,
    required this.genreName,
    required this.allMovies,
  });

  @override
  Widget build(BuildContext context) {
    final genreMovies = allMovies.where((movie) {
      if (movie.genres == null) return false;
      return movie.genres!.any(
            (g) => g.toLowerCase().trim() == genreName.toLowerCase().trim(),
      );
    }).toList();

    return Container(
      height: context.height * 0.75,
      padding: EdgeInsets.all(context.width * 0.04),
      decoration: const BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: context.width*0.1,
              height: context.height*0.005,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: context.height * 0.02),
          Text(
            genreName,
            style: AppTextStyels.White20regular,
          ),
          SizedBox(height: context.height * 0.02),
          Expanded(
            child: GridView.builder(
              physics:  BouncingScrollPhysics(),
              itemCount: genreMovies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: context.width * 0.03,
                mainAxisSpacing: context.height * 0.02,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: genreMovies[index],
                  width: double.infinity,
                  height: context.width,
                  isright: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}