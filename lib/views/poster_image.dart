import 'package:binge/services/tmdb_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({
    Key? key,
    required this.scaleFactor,
    required this.imagePath,
    this.hero = false,
  }) : super(key: key);

  static final TMDBService tmdb = TMDBService();
  final num? scaleFactor;
  final String? imagePath;
  final bool hero;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath != null
          ? tmdb.createImageURL(imagePath!, hero)
          : "https://v4.akisan.ml/assets/favicon.png",
      width: getWidth(context),
      height: getHeight(context),
      imageBuilder: (context, imageProvider) {
        return Container(
          width: getWidth(context),
          height: getHeight(context),
          decoration: BoxDecoration(
            borderRadius:
                !hero ? const BorderRadius.all(Radius.circular(8)) : null,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) {
        if (hero) {
          // Use small img for Hero transition if big is not in cache
          return PosterImage(
              scaleFactor: getWidth(context) / 92, imagePath: imagePath);
        }
        return SizedBox(
          width: getWidth(context),
          height: getHeight(context),
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

  double getWidth(BuildContext context) {
    if (hero) {
      return MediaQuery.of(context).size.width;
    } else {
      if (scaleFactor != null) {
        return scaleFactor! * 92;
      }
      return 92;
    }
  }

  double getHeight(BuildContext context) {
    if (hero) {
      return MediaQuery.of(context).size.width * 1.5;
    } else {
      if (scaleFactor != null) {
        return scaleFactor! * 138;
      }
      return 138;
    }
  }
}
