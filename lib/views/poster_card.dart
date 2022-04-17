import 'package:binge/models/tmdb/tmdb_result.dart';
import 'package:binge/pages/detail_page.dart';
import 'package:binge/views/poster_image.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    Key? key,
    required this.item,
    this.scaleFactor,
    required this.index,
    required this.listName,
    this.extraLine = false,
  }) : super(key: key);

  final TMDBResults item;
  final num? scaleFactor;
  final String listName;
  final int index;
  final bool extraLine;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            item: item,
            heroKey: '$listName$index',
          ),
        ),
      ),
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.fromLTRB(6, 8, 6, 8),
        child: SizedBox(
          width: scaleFactor != null ? scaleFactor! * 92 : 92,
          height: scaleFactor != null ? scaleFactor! * 138 : 138,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: '$listName$index',
                child: PosterImage(
                    scaleFactor: scaleFactor, imagePath: item.posterPath),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: extraLine
                      ? scaleFactor != null
                          ? scaleFactor! * 42
                          : 42
                      : scaleFactor != null
                          ? scaleFactor! * 38
                          : 38,
                  width: scaleFactor != null ? scaleFactor! * 92 : 92,
                  child: AutoSizeText(
                    item.name ?? "",
                    textAlign: TextAlign.center,
                    maxLines: extraLine ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
