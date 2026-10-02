import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/screens/widgets/movie_card.dart';

import '../../../core/utils/mob_size.dart';
import '../cubit/browse_cubit.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseCubit()..initBrowse(),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<BrowseCubit, BrowseState>(
            builder: (context, state) {
              final cubit = context.read<BrowseCubit>();

              if (state is BrowseInitialLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (state is BrowseErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                );
              }

              return Column(
                children: [
                  SizedBox(height: context.height * 0.02),
                  SizedBox(
                    height: context.height * 0.06,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.03,
                      ),
                      itemCount: cubit.genresList.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: context.width * 0.025),
                      itemBuilder: (context, index) {
                        final genre = cubit.genresList[index];
                        final isSelected = genre == cubit.selectedGenre;
                        return ChoiceChip(
                          showCheckmark: false,
                          label: Text(genre),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              cubit.selectGenre(genre);
                            }
                          },
                          selectedColor: AppColors.primaryColor,
                          backgroundColor: AppColors.blackColor,
                          side: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          labelStyle: TextStyle(
                            fontSize: context.height * 0.022,
                            color: isSelected
                                ? AppColors.blackColor
                                : AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              context.height * 0.02,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.height * 0.02),
                  Expanded(
                    child: state is BrowseMoviesLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.04,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.68,
                                  crossAxisSpacing: context.width * 0.04,
                                  mainAxisSpacing: context.height * 0.02,
                                ),
                            itemCount: cubit.currentMovies.length,
                            itemBuilder: (context, index) {
                              final movie = cubit.currentMovies[index];
                              return MovieCard(
                                  movie: movie,
                                  width: context.width * 1.2,
                                  height: context.height * 1.3,
                              );
                              // return MovieCard(
                              //   rating: movie.rating?.toString() ?? '0.0',
                              //   imageUrl:
                              //       movie.largeCoverImage ??
                              //       movie.mediumCoverImage ??
                              //       '',
                              // );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


