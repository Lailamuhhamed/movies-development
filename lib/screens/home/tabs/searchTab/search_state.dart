// screens/home/tabs/searchTab/search_state.dart
import 'package:movies_app/core/utils/Model/movie_model/Movies_source.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final MoviesSource moviesSource;

  SearchSuccessState(this.moviesSource);
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState(this.errorMessage);
}