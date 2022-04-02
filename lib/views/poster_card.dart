import 'package:binge/models/tmdb_result.dart';
import 'package:binge/services/tmdb_service.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({Key? key, required this.text}) : super(key: key);

  final TMDBResults text;
  static final TMDBService tmdb = TMDBService();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: 92,
        height: 138,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: tmdb.createImageURL(text.posterPath!),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                width: 92,
                height: 138,
                child: Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                text.name!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
