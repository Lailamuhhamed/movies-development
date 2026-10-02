// screens/home/tabs/searchTab/searchView.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_routs.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import 'package:movies_app/core/utils/Model/movie_model/Movies.dart';
import 'package:movies_app/screens/widgets/movie_card.dart';

import 'search_cubit.dart';
import 'search_state.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController =
      TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  // Wait for the user to stop typing before calling the API
  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        if (!mounted) return;

        context.read<SearchCubit>().searchMovies(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = context.width;
    final double height = context.height;

    return Scaffold(
      backgroundColor: AppColors.blackColor,

      body: SafeArea(
        child: Column(
          children: [
            // ================= SEARCH BAR =================

            Padding(
              padding: EdgeInsets.only(
                left: width * 0.02,
                right: width * 0.02,
                top: height * 0.01,
              ),
              child: SizedBox(
                height: height * 0.06,
                child: TextField(
                  controller: searchController,
                  onChanged: _onSearchChanged,
                  style: AppTextStyels.White14regular,
                  cursorColor: AppColors.primaryColor,

                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: AppTextStyels.White14regular,

                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.whiteColor,
                      size: width * 0.065,
                    ),

                    filled: true,
                    fillColor: AppColors.darkGrey,

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        width * 0.035,
                      ),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        width * 0.035,
                      ),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        width * 0.035,
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.015),

            // ================= SEARCH RESULTS =================

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  // Show initial message before searching
                  if (state is SearchInitialState) {
                    return Center(
                      child: Text(
                        'Search for a movie',
                        style: AppTextStyels.White16regular,
                      ),
                    );
                  }

                  // Show loading indicator while fetching data
                  if (state is SearchLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  // Show error message if the request fails
                  if (state is SearchErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTextStyels.White16regular,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  // Show movies when the request succeeds
                  if (state is SearchSuccessState) {
                    final List<Movies> movies =
                        state.moviesSource.data?.movies ?? [];

                    // Show message when no movies match the search
                    if (movies.isEmpty) {
                      return Center(
                        child: Text(
                          'No movies found',
                          style:
                              AppTextStyels.White16regular,
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.005,
                      ),

                      physics:
                          const BouncingScrollPhysics(),

                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        crossAxisSpacing:
                            width * 0.035,

                        mainAxisSpacing:
                            height * 0.015,

                        childAspectRatio: 0.62,
                      ),

                      itemCount: movies.length,

                      itemBuilder: (context, index) {

                        return MovieCard(movie: movies[index], width: width, height: height, isright: false,);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

  );
  }
}

