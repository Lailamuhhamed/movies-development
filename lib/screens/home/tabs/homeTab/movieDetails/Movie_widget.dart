import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/Model/movie_details/Movie.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_routs.dart';
import 'package:movies_app/core/utils/app_text_styels.dart';
import 'package:movies_app/screens/home/tabs/homeTab/movieDetails/movie_suggest_response.dart';
import 'package:movies_app/screens/home/tabs/profileTab/watchList/watch_list.dart';
import 'package:movies_app/screens/widgets/Custom_container_rate.dart';
import 'package:movies_app/screens/widgets/ScreenShot_image.dart';
import 'package:movies_app/screens/widgets/cast_container.dart';
import 'package:movies_app/screens/widgets/custom_elevated_button.dart';
import 'package:movies_app/screens/widgets/genres_container.dart';

import '../../../../../core/utils/mob_size.dart';

class MovieWidget extends StatefulWidget {
 final  Movie movie;

  MovieWidget({super.key, required this.movie, });

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  final currentUser = FirebaseAuth.instance.currentUser;





 /*Future<void> _markMovieAsWatched(BuildContext context) async {
   try {
     final user = FirebaseAuth.instance.currentUser;
     if (user == null) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Please log in first!')),
       );
       return;
     }

     await FirebaseFirestore.instance
         .collection('users')
         .doc(user.uid)
         .collection('watched_movies')
         .doc(movie.id.toString())
         .set({
       'movieId': movie.id,
       'title': movie.title ?? '',
       'posterPath': movie.largeCoverImage ?? '',
       'watchedAt': FieldValue.serverTimestamp(),
     });

     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Added to Watched History successfully!')),
     );
   } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Error: ${e.toString()}')),
     );
   }
 }
*/

 /*Future<void> _markMovieAsWatched(BuildContext context) async {
   try {
     const dummyUserId = "test_user_id";

     await FirebaseFirestore.instance
         .collection('users')
         .doc(dummyUserId)
         .collection('watched_movies')
         .doc(movie.id.toString())
         .set({
       'movieId': movie.id,
       'title': movie.title ?? '',
       'posterPath': movie.largeCoverImage ?? '',
       'watchedAt': FieldValue.serverTimestamp(),
     });

     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Added to Watched History successfully!')),
     );
   } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Error: ${e.toString()}')),
     );
   }
 }
 */
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;


    return SingleChildScrollView(
      child: Stack(
        children: [
          CachedNetworkImage(imageUrl: widget.movie.largeCoverImage??''),
          Image.asset(AppAssets.movieShadow, fit: BoxFit.fill,),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: height*0.02, horizontal: width*0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: height*0.015,

              children: [
                SizedBox(
                  height: height*0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                  ,children: [
                    IconButton(onPressed: (){
                      Navigator.popUntil(context, ModalRoute.withName(AppRouts.homeRouteName));
                    },
                        icon: Icon(Icons.arrow_back_ios_new,color: AppColors.whiteColor, size: 30,)),

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentUser!.uid)
                        .collection('wish_list')
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
                        return Icon( Icons.bookmark_border, color: AppColors.whiteColor,size: 30,);
                      }

                      if (!snapshot.hasData ) {
                        return Icon( Icons.bookmark_border, color: AppColors.whiteColor,size: 30,);
                      }


                      final docs = snapshot.data!.docs;
                      final bool isFav = docs.any((element) => element.id == widget.movie.id.toString(),);



                      return IconButton(onPressed: ()  {
                        if(!isFav){
                          _FavMovieOnTap(context);

                        }else{
                          _RemoveFavMovieOnTap(context);

                        }
                      },
                        icon: Icon( isFav?Icons.bookmark:Icons.bookmark_border, color: AppColors.whiteColor,size: 30,));
                    },
                  )

                  ],
                ),
                SizedBox(
                  height: height*0.15,
                ),
                IconButton(onPressed: (){},
                    icon: Image.asset(AppAssets.watch)),
                SizedBox(
                  height: height*0.15,
                ),
                Text(widget.movie.title??'',
                  style: AppTextStyels.white24bold,),
                Text('${widget.movie.year??''}',
                  style: AppTextStyels.grey20bold,),
                CustomElevatedButton(text: context.tr("watch"),
                    func: () {},
                    color: AppColors.redColor, textStyle: AppTextStyels.white20bold),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomContainerRate(icon: Icons.favorite, rate: widget.movie.likeCount),
                    CustomContainerRate(icon: Icons.watch_later, rate: widget.movie.runtime),
                    CustomContainerRate(icon: Icons.star, rate: widget.movie.rating),

                  ],
                ),
                SizedBox(
                  width: width,
                    child: Text(context.tr("screen_shots"), style: AppTextStyels.white24bold,textAlign: TextAlign.start,)),
                ScreenshotImage(image: widget.movie.largeScreenshotImage1),
                ScreenshotImage(image: widget.movie.largeScreenshotImage2),
                ScreenshotImage(image: widget.movie.largeScreenshotImage3),
                SizedBox(
                    width: width,
                    child: Text(context.tr("similar"), style: AppTextStyels.white24bold,textAlign: TextAlign.start,)),
                MovieSuggestResponse(movieId: widget.movie.id!),
                if(widget.movie.descriptionFull!=null && widget.movie.descriptionFull !='')
                  SizedBox(
                    width: width,
                    child: Text(context.tr("summary"),
                      style: AppTextStyels.white24bold,textAlign: TextAlign.start,)),
                Text(widget.movie.descriptionFull??'',
                  style: AppTextStyels.White16regular,),
                SizedBox(
                    width: width,
                    child: Text(context.tr("cast"),
                      style: AppTextStyels.white24bold,textAlign: TextAlign.start,)),
                if(widget.movie.cast!=null && widget.movie.cast!.isNotEmpty)
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CastContainer(actor: widget.movie.cast![index]);
                    },
                  itemCount: widget.movie.cast!.length,
                ),
                SizedBox(
                    width: width,
                    child: Text(context.tr("genres"),
                      style: AppTextStyels.white24bold,textAlign: TextAlign.start,)),
                if(widget.movie.genres!=null && widget.movie.genres!.isNotEmpty)
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                        mainAxisSpacing: height*0.02,
                        crossAxisSpacing: width*0.04,
                      childAspectRatio: 2.5
                    ),
                    itemBuilder: (context, index) {
                      return GenresContainer(genres: widget.movie.genres![index]);
                    },
                  itemCount: widget.movie.genres!.length,
                )





              ],
            ),
          )
        ],
      ),
    );
  }

 Future<void> _FavMovieOnTap(BuildContext context) async {
   try {


     if (currentUser == null) return;

     await FirebaseFirestore.instance
         .collection('users')
         .doc(currentUser!.uid)
         .collection('wish_list')
         .doc((widget.movie.id ?? 0).toString())
         .set({
       'movieId': widget.movie.id ?? 0,
       'title': widget.movie.title ?? '',
       'posterPath': widget.movie.mediumCoverImage ?? widget.movie.largeCoverImage ?? '',
       'rating': widget.movie.rating ?? 0.0,
       'watchedAt': FieldValue.serverTimestamp(),
     });
     setState(() {

     });
   } catch (e) {
     debugPrint('Error saving movie on tap: $e');
   }
 }

 Future<void> _RemoveFavMovieOnTap(BuildContext context) async {
   try {


     if (currentUser == null) return;

     await FirebaseFirestore.instance
         .collection('users')
         .doc(currentUser!.uid)
         .collection('wish_list')
         .doc((widget.movie.id ?? 0).toString()).delete();
     setState(() {

     });
   } catch (e) {
     debugPrint('Error saving movie on tap: $e');
   }
 }
}
