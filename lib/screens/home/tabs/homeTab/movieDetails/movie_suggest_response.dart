import 'package:flutter/material.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/core/utils/Model/movie_model/Movies.dart';
import 'package:movies_app/screens/home/tabs/homeTab/movieDetails/movie_suggest_widget.dart';
import 'package:movies_app/screens/widgets/Main_loading_widget.dart';
import 'package:movies_app/screens/widgets/main_Error_widget.dart';

class MovieSuggestResponse extends StatefulWidget {
  final int movieId;
  const MovieSuggestResponse({super.key, required this.movieId});

  @override
  State<MovieSuggestResponse> createState() => MovieSuggestResponseState();
}

class MovieSuggestResponseState extends State<MovieSuggestResponse> {
  ApiService apiService = ApiService();
  late Future<List<Movies>> movieSuggest;

  @override
  void initState() {
    super.initState();
    movieSuggest = apiService.getMovieSuggestion(MovieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movies>>(
      future: movieSuggest,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainLoadingWidget();
        } else if (snapshot.hasError) {
          print(widget.movieId);
          return MainErrorWidget(
            errorMessage: 'Error: ${snapshot.error}',
            func1: () {
              // Try Again
              setState(() {
                movieSuggest = apiService.getMovieSuggestion(MovieId: widget.movieId);
              });
            },
            func2: () {
              // Exit
              Navigator.pop(context);
            },
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return MainErrorWidget(
            errorMessage: 'No Details Available',
            func1: () {
              // Try Again
              setState(() {
                movieSuggest = apiService.getMovieSuggestion(MovieId: widget.movieId);
              });
            },
            func2: () {
              // Exit
              Navigator.pop(context);
            },
          );
        } else {
          final movies = snapshot.data!;
          return MovieSuggestWidget(movies: movies);
        }
      },
    );
  }
}