import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../services/tmdb_service.dart';

class TMDBImage extends StatelessWidget {
  const TMDBImage({
    Key? key,
    required this.imagePath,
    this.width = 92,
    this.scaleFactor,
    this.heroImage = false,
    this.bannerImage = false,
  }) : super(key: key);

  final String? imagePath;
  final num? scaleFactor;

  final double? width;

  final bool heroImage;
  final bool bannerImage;

  double getHeight() {
    if (scaleFactor != null) {
      return 138.0 * scaleFactor!;
    }

    // if (bannerImage) {
    //   return 169;
    // }

    if (width != null && bannerImage != true) {
      return width! * 1.5;
    }

    if (width != null && bannerImage == true) {
      return (width! / 300.0) * 169;
    }

    return 138;
  }

  double getWidth() {
    if (scaleFactor != null) {
      return 92.0 * scaleFactor!;
    }

    // if (bannerImage) {
    //   return 300;
    // }

    if (width != null) {
      return width!;
    }

    return 92;
  }

  // Image URL
  static const _thumbnailUrl = 'https://image.tmdb.org/t/p/w92';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _bannerUrl = 'https://image.tmdb.org/t/p/w300';

  // Thumbnail, 92W, 138H
  // Image, 500W, 750H // H is 1.5X W
  // 300 W H 169 - Banner
  String getImageUrl(String? path, bool hero, bool banner) {
    if (path == null || path == '') {
      return 'https://v4.akisan.ml/assets/favicon.png';
    }

    if (hero) {
      return _imageUrl + path;
    }

    if (banner) {
      return _bannerUrl + path;
    }

    return _thumbnailUrl + path;
  }

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: getImageUrl(imagePath, heroImage, bannerImage),
        height: getHeight(),
        width: getWidth(),
        imageBuilder: (context, imageProvider) => Container(
          height: getHeight(),
          width: getWidth(),
          decoration: BoxDecoration(
            borderRadius:
                heroImage ? null : const BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => heroImage
            ? TMDBImage(
                imagePath: imagePath,
                width: getWidth(),
              )
            : SizedBox(
                height: getHeight(),
                width: getWidth(),
                child: Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
              ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
}
