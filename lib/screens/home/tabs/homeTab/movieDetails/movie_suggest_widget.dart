import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/movie_model/Movies.dart';
import 'package:movies_app/screens/widgets/movie_card.dart';
import '../../../../../core/utils/mob_size.dart';

class MovieSuggestWidget extends StatelessWidget {
 final List<Movies> movies;
  const MovieSuggestWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return GridView.builder(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsetsGeometry.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            mainAxisSpacing: height*0.02, childAspectRatio: 0.75),
        itemBuilder: (context, index) {
          return MovieCard(movie: movies[index], width:width*0.3,height: height*0.4, );
        },
      itemCount: movies.length>4?4:movies.length,
    );
  }
}
