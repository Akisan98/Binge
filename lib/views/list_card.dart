import 'dart:convert';
import 'dart:developer';

import 'package:binge/models/tmdb_result.dart';
import 'package:binge/services/shared_preferences_service.dart';
import 'package:binge/utils/utils.dart';
import 'package:binge/views/poster_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key, required this.item}) : super(key: key);

  final TMDBResults item;
  final num scaleFactor = 1;
  static Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => {
        spService.addHistory(jsonEncode(item)),
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            PosterImage(scaleFactor: 1, imagePath: item.posterPath),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: screenWidth - 92 - 16 - 16 - 16 - 16,
                      child: AutoSizeText(
                        item.name ?? "",
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
                      resolveMediaType(item.mediaType, item.gender) +
                          resolveYear(item.firstAirDate),
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
                        resolveGenre(item.genreIds),
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

  resolveMediaType(String? type, int? genre) {
    switch (type) {
      case 'tv':
        return 'TV Series';
      case 'person':
        return genre == 1 ? 'Actress' : 'Actor';
      case 'movie':
        return 'Movie';
      default:
        return '';
    }
  }

  resolveYear(String? date) {
    if (!utils.isEmptyOrNull(date)) {
      return '  •  ${DateTime.parse(date!).year.toString()}';
    }
    return '';
  }

  resolveGenre(List<int>? ids) {
    String genres = '';

    if (!utils.isEmptyOrNull(ids)) {
      for (var i = 0; i < ids!.length; i++) {
        if (i != ids.length - 1) {
          genres += '${utils.getGenre(ids[i])}, ';
        } else {
          genres += utils.getGenre(ids[i]);
        }
      }
    }
    return genres;
  }
}
