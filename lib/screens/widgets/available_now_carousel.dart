import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import '../../core/utils/Model/movie_model/Movies.dart';
import 'movie_card.dart';

class AvailableNowCarousel extends StatefulWidget {
  final List<Movies> movies;

  const AvailableNowCarousel({super.key, required this.movies});

  @override
  State<AvailableNowCarousel> createState() => _AvailableNowCarouselState();
}

class _AvailableNowCarouselState extends State<AvailableNowCarousel> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return SizedBox(
        child:  Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );
    }

    final currentMovie = widget.movies[_selectedIndex];
    final currentBgImage =
        currentMovie.largeCoverImage ?? currentMovie.mediumCoverImage ?? '';

    return SizedBox(
      height: context.height * 0.69,
      child: Stack(
        children: [
          // Dynamic Blurred Background Image
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Container(
                key: ValueKey<String>(currentBgImage),
                decoration: BoxDecoration(
                  image: currentBgImage.isNotEmpty
                      ? DecorationImage(
                    image: NetworkImage(currentBgImage),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 4),
                  child: Container(
                    color: AppColors.blackColor.withOpacity(0.55),
                  ),
                ),
              ),
            ),
          ),

          // Foreground Layer
          Column(
            children: [
              SizedBox(height: context.height * 0.04),

              // Header Image
              Image.asset(AppAssets.availableNow),

              SizedBox(height: context.height * 0.01),

              Expanded(
                child: CarouselSlider.builder(
                  itemCount: widget.movies.length,
                  itemBuilder: (context, index, realIndex) {
                    final movie = widget.movies[index];
                    return MovieCard(width:context.width*0.6,movie: movie, height: context.height * 0.23,);
                  },
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 0.54,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.35,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),

              Image.asset(AppAssets.watchNow),
            ],
          ),
        ],
      ),
    );
  }
}