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
  const DBContent({
    Key? key,
    required this.item,
    required this.index,
    this.countDown = false,
  }) : super(key: key);

  final MediaContent? item;
  final int index;
  final bool countDown;

  TMDBResults toRes(MediaContent? dbContent) => TMDBResults(
        id: dbContent?.tmdbId,
        mediaType: dbContent?.type == MediaType.movie
            ? MediaType.movie.string
            : MediaType.tvSeries.string,
        posterPath: dbContent?.posterPath,
      );

  @override
  Widget build(BuildContext context) {
    log('DBContent - Build');

    log(item.toString());
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
                      width: screenWidth -
                          92 -
                          16 -
                          16 -
                          16 -
                          16 -
                          (countDown ? 64 : 0),
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
                    width: screenWidth -
                        92 -
                        16 -
                        16 -
                        16 -
                        16 -
                        (countDown ? 64 : 0),
                    child: AutoSizeText(
                      countDown
                          ? item?.nextRelease ?? ''
                          : item?.nextToWatch?.airDate ?? '',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SizedBox(
                      width: screenWidth -
                          92 -
                          16 -
                          16 -
                          16 -
                          16 -
                          (countDown ? 64 : 0),
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
            countDown
                ? Container(
                    height: 64,
                    width: 64,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            resolveCounter(item)[0],
                            textScaleFactor: 1.25,
                          ),
                          Text(
                            resolveCounter(item)[1],
                            textScaleFactor: 0.75,
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        )))
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  List<String> resolveCounter(MediaContent? db) {
    if (db == null || item?.nextRelease == null || item?.nextRelease == '') {
      return ['', ''];
    }

    final comp = DateTime.now().difference(DateTime.parse(item!.nextRelease!));
    if (comp.inDays < 0) {
      return [(comp.inDays - 1).abs().toString(), 'Days'];
    }

    return [(comp.inHours - 1).abs().toString(), 'Hours'];
  }

  String resolveSubtext(MediaContent? db) {
    //log(db.toString());
    if (db?.type == MediaType.movie) {
      if (db?.genres != null) {
        return db!.genres.toString();
      }
    } else {
      int season;
      int episode;
      String episodeName;
      String output = '';

      if (db?.title == 'The Falcon and the Winter Soldier') {
        log(db.toString());
      }

      var item = countDown ? db?.nextToAir : db?.nextToWatch;

      if (item != null) {
        episodeName = item.name ?? '';
        season = item.seasonNumber ?? -1;
        episode = item.episodeNumber ?? -1;

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
    return 'gg';
  }
}
