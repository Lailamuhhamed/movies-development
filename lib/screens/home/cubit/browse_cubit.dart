import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/dio_manager.dart';
import '../../../core/utils/Model/movie_model/Movies.dart';


abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}


class BrowseInitialLoadingState extends BrowseState {}


class BrowseMoviesLoadingState extends BrowseState {}

class BrowseSuccessState extends BrowseState {
  final List<String> genres;
  final List<Movies> movies;
  final String selectedGenre;

  BrowseSuccessState({
    required this.genres,
    required this.movies,
    required this.selectedGenre,
  });
}

class BrowseErrorState extends BrowseState {
  final String message;
  BrowseErrorState(this.message);
}


class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseInitialState());

  final List<String> genresList = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Thriller',
    'War',
    'Western',
  ];

  String selectedGenre = 'Action';
  List<Movies> currentMovies = [];


  Future<void> initBrowse() async {
    emit(BrowseInitialLoadingState());
    await fetchMovies();
  }


  Future<void> selectGenre(String genre) async {
    if (selectedGenre == genre) return;
    selectedGenre = genre;
    emit(BrowseMoviesLoadingState());
    await fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final source = await ApiService.getMovies(genre: selectedGenre);
      currentMovies = source.data?.movies ?? [];
      emit(
        BrowseSuccessState(
          genres: genresList,
          movies: currentMovies,
          selectedGenre: selectedGenre,
        ),
      );
    } catch (e) {
      emit(BrowseErrorState(e.toString()));
    }
  }
}