import 'package:binge/models/tmdb_result.dart';
import 'package:binge/services/tmdb_service.dart';
import 'package:binge/views/poster_image.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

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
            PosterImage(scaleFactor: scaleFactor, imagePath: text.posterPath),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: scaleFactor != null ? scaleFactor! * 38 : 38,
                width: scaleFactor != null ? scaleFactor! * 92 : 92,
                child: AutoSizeText(
                  text.name ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
