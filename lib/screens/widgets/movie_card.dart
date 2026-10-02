import 'package:cloud_firestore/cloud_firestore.dart'; // 1. استيراد فايربيز
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/movie_model/Movies.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_routs.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/mob_size.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;
  final double width;
  final double height;
  final bool isright ;

  const MovieCard({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
     this.isright = true
  });

  Future<void> _saveMovieOnTap(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) return;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('watched_movies')
          .doc((movie.id ?? 0).toString())
          .set({
        'movieId': movie.id ?? 0,
        'title': movie.title ?? '',
        'posterPath': movie.mediumCoverImage ?? movie.largeCoverImage ?? '',
        'rating': movie.rating ?? 0.0, // <-- ضفنا تخزين الـ rating هنا
        'watchedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error saving movie on tap: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.mediumCoverImage ?? movie.largeCoverImage ?? '';

    return InkWell(
        onTap: () async {
          await _saveMovieOnTap(context);

          if (context.mounted) {
            Navigator.pushNamed(
              context,
              AppRouts.MovieDetailsscreen,
              arguments: movie.id,
            );
          }
        },
        child: Container(
          width: width,
          height: context.height * 0.23,
          margin: isright?EdgeInsets.only(right: context.width * 0.03):null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned.fill(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: AppColors.blackColor.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.darkGrey,

                        child: Icon(
                          Icons.movie_outlined,
                          color: AppColors.whiteColor,
                          size: width * 0.12,
                        ),
                      );
                    },
                  )
                      : Container(color: Colors.grey[900]),
                ),

                Positioned(
                  top: context.height * 0.01,
                  left: context.width * 0.02,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.018,
                      vertical: context.height * 0.003,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${movie.rating ?? 0.0}',
                          style: AppTextStyels.White16regular.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: context.width * 0.01),
                        Image.asset(
                          AppAssets.star,
                          width: context.width*0.03,
                          height: context.height*0.022,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}