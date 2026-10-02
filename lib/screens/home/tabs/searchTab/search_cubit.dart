// screens/home/tabs/searchTab/search_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  Future<void> searchMovies(String query) async {
    final String searchQuery = query.trim();

    if (searchQuery.isEmpty) {
      emit(SearchInitialState());
      return;
    }

    emit(SearchLoadingState());

    try {
      final result = await ApiService.getMovies(
        queryTerm: searchQuery,
      );

      emit(SearchSuccessState(result));
    } catch (e) {
      emit(
        SearchErrorState(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }
}