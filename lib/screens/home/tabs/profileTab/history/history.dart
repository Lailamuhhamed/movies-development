import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/movie_model/Movies.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styels.dart';
import 'package:movies_app/core/utils/mob_size.dart';
import '../../../../widgets/movie_card.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('watched_movies')
          .orderBy('watchedAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong",
              style: AppTextStyels.white20bold,
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No watch history yet!",
              style: AppTextStyels.white20bold,
            ),
          );
        }

        final docs = snapshot.data!.docs;

        return GridView.builder(
          padding: EdgeInsets.all(context.width * 0.04),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: context.width * 0.03,
            mainAxisSpacing: context.height * 0.02,
            childAspectRatio: 0.6,
          ),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final movieData = docs[index].data() as Map<String, dynamic>;

            final movie = Movies(
              id: movieData['movieId'],
              title: movieData['title'],
              rating: (movieData['rating'] ?? 0.0).toDouble(),
              mediumCoverImage: movieData['posterPath'],
            );

            return MovieCard(
              movie: movie,
              width: double.infinity,
              height: context.height * 0.23,
              isright: false,
            );
          },
        );
      },
    );
  }
}