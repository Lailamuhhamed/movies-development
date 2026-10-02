import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/widgets/Main_loading_widget.dart';

class ScreenshotImage extends StatelessWidget {
  var image;
   ScreenshotImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(16),
      clipBehavior: Clip.antiAlias,
      child:CachedNetworkImage(
        imageUrl: image??'',
        placeholder: (context, url) => MainLoadingWidget(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
