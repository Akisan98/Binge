import 'package:binge/models/tmdb_result.dart';
import 'package:binge/services/tmdb_service.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({Key? key, required this.text, this.scaleFactor})
      : super(key: key);

  final TMDBResults text;
  final num? scaleFactor;
  static final TMDBService tmdb = TMDBService();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: SizedBox(
        width: scaleFactor != null ? scaleFactor! * 92 : 92,
        height: scaleFactor != null ? scaleFactor! * 138 : 138,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: text.posterPath != null
                  ? tmdb.createImageURL(text.posterPath!)
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
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                );
              },
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return SizedBox(
                  width: scaleFactor != null ? scaleFactor! * 92 : 92,
                  height: scaleFactor != null ? scaleFactor! * 138 : 138,
                  child: Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                );
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: scaleFactor != null ? scaleFactor! * 38 : 38,
                  width: scaleFactor != null ? scaleFactor! * 92 : 92,
                  child: AutoSizeText(
                    text.name!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
