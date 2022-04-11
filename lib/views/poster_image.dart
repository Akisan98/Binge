import 'package:binge/services/tmdb_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({
    Key? key,
    required this.scaleFactor,
    required this.imagePath,
  }) : super(key: key);

  static final TMDBService tmdb = TMDBService();
  final num? scaleFactor;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath != null
          ? tmdb.createImageURL(imagePath!)
          : "https://v4.akisan.ml/assets/favicon.png",
      width: scaleFactor != null ? scaleFactor! * 92 : 92,
      height: scaleFactor != null ? scaleFactor! * 138 : 138,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: scaleFactor != null ? scaleFactor! * 92 : 92,
          height: scaleFactor != null ? scaleFactor! * 138 : 138,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return SizedBox(
          width: scaleFactor != null ? scaleFactor! * 92 : 92,
          height: scaleFactor != null ? scaleFactor! * 138 : 138,
          child: Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
