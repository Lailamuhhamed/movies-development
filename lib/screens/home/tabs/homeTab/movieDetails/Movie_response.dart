import 'package:flutter/material.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/core/utils/Model/movie_details/Movie.dart';
import 'package:movies_app/screens/home/tabs/homeTab/movieDetails/Movie_widget.dart';
import 'package:movies_app/screens/widgets/Main_loading_widget.dart';
import 'package:movies_app/screens/widgets/main_Error_widget.dart';

class MovieResponse extends StatefulWidget {
  final int movieId;
  const MovieResponse({super.key, required this.movieId});

  @override
  State<MovieResponse> createState() => _MovieResponseState();
}

class _MovieResponseState extends State<MovieResponse> {
  ApiService apiService = ApiService();
  late Future<Movie> movie;

  @override
  void initState() {
    super.initState();
    movie = apiService.getMovieDetails(MovieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
      future: movie,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainLoadingWidget();
        } else if (snapshot.hasError) {
          return MainErrorWidget(
            errorMessage: 'Error: ${snapshot.error}',
            func1: () {
              // Try Again (إعادة تحميل الـ Future)
              setState(() {
                movie = apiService.getMovieDetails(MovieId: widget.movieId);
              });
            },
            func2: () {
              // Exit (الرجوع للصفحة السابقة)
              Navigator.pop(context);
            },
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return MainErrorWidget(
            errorMessage: 'No Details Available',
            func1: () {
              // Try Again
              setState(() {
                movie = apiService.getMovieDetails(MovieId: widget.movieId);
              });
            },
            func2: () {
              // Exit
              Navigator.pop(context);
            },
          );
        } else {
          print('${snapshot.data!.largeScreenshotImage1 ?? 'no data'}');
          final movieDetails = snapshot.data!;
          return MovieWidget(movie: movieDetails);
        }
      },
    );
  }
}