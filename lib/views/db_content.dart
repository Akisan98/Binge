import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/media_type.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_result.dart';
import '../pages/detail_page.dart';
import 'tmdb_image.dart';

class DBContent extends StatelessWidget {
  const DBContent({Key? key, required this.item, required this.index})
      : super(key: key);

  final MediaContent? item;
  final int index;

  TMDBResults toRes(MediaContent? dbContent) => TMDBResults(
        id: dbContent?.tmdbId,
        mediaType: dbContent?.type == MediaType.movie
            ? MediaType.movie.string
            : MediaType.tvSeries.string,
        posterPath: dbContent?.posterPath,
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              item: toRes(item),
              heroKey: 'poster$index',
            ),
          ),
        ),
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Hero(
              tag: 'poster$index',
              child: TMDBImage(scaleFactor: 1, imagePath: item?.posterPath),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: screenWidth - 92 - 16 - 16 - 16 - 16,
                      child: AutoSizeText(
                        item?.title ?? '',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.25,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth - 92 - 16 - 16 - 16 - 16,
                    child: AutoSizeText(
                      item?.nextRelease ?? '',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SizedBox(
                      width: screenWidth - 92 - 16 - 16 - 16 - 16,
                      child: AutoSizeText(
                        resolveSubtext(item),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(),
            // Icon(Icons.add),
          ],
        ),
      ),
    );
  }

  String resolveSubtext(MediaContent? db) {
    log(db.toString());
    if (db?.type == MediaType.movie) {
      if (db?.genres != null) {
        return db!.genres.toString();
      }
    } else {
      int season;
      int episode;
      String episodeName;
      String output = '';

      if (db?.nextToAir != null) {
        episodeName = db!.nextToAir?.name ?? '';
        season = db.nextToAir?.seasonNumber ?? -1;
        episode = db.nextToAir?.episodeNumber ?? -1;

        if (season != -1 && episode != -1) {
          output += 'S$season E$episode';
        }

        if (episodeName != '') {
          if (output != '') {
            output += ' | $episodeName';
          } else {
            output += episodeName;
          }
        }
      }
      return output;
    }
    return '';
  }
}
