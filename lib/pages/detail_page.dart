import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../enums/media_type.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_credit.dart';
import '../models/tmdb/tmdb_detail.dart';
import '../models/tmdb/tmdb_result.dart';
import '../services/tmdb_service.dart';
import '../utils/utils.dart';
import '../views/genre_card.dart';
import '../views/poster_card.dart';
import '../views/season_list.dart';
import '../views/tmdb_image.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.item,
    this.heroKey,
  }) : super(key: key);

  final TMDBResults item;
  final String? heroKey;
  static Utils utils = Utils();
  static TMDBService tmdb = TMDBService();

  static late MediaContent content;

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    log('Build - DetailPage');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: heroKey ?? '',
                child: TMDBImage(
                  width: MediaQuery.of(context).size.width,
                  imagePath: item.posterPath,
                  heroImage: true,
                ),
              ),
              FutureBuilder<TMDBDetail>(
                future: tmdb.getDetails(item.mediaType, item.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    content = MediaContent.fromDetails(snapshot.data);

                    // log(snapshot.data!.toString());
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                child: AutoSizeText(
                                  snapshot.data?.title ?? '',
                                  maxLines: 2,
                                  textScaleFactor: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          if (item.mediaType != MediaType.person.string &&
                              !utils.isNullOrEmpty(snapshot.data?.voteAverage))
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 28,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: formatRating(
                                      snapshot.data?.voteAverage,
                                    ).toString(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: ' / 10.0',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 32),
                                  child: Text('Rate'),
                                ),
                              ],
                            )
                          else
                            const SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: item.mediaType != MediaType.person.string
                                ? Text(formatString(snapshot.data))
                                : Text(safeString(snapshot.data?.birthday)),
                          ),
                          if (item.mediaType != MediaType.person.string)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 16,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.genres?.length ?? 0,
                                  itemBuilder: (context, index) => GenreCard(
                                    genre: snapshot.data?.genres?[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const Text(', '),
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text(snapshot.data?.tagline ?? ''),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(snapshot.data?.overview ?? ''),
                          ),
                          if (item.mediaType == MediaType.tvSeries.string)
                            SeasonList(
                              seasons: content.seasons,
                              showId: item.id ?? 1,
                              onPressed: (seenCount, seasonNumber) {
                                content.seasons?[findSeason(seasonNumber)]
                                    .episodesSeen = seenCount;
                                log(content.seasons![findSeason(seasonNumber)]
                                    .episodesSeen
                                    .toString());
                              },
                            )
                          else
                            const SizedBox.shrink(),
                          // Text(snapshot.data!.toJson().toString()),
                        ],
                      ),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
              FutureBuilder<TMDBCredit>(
                future: tmdb.getCredits(item.id, item.mediaType),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8, bottom: 8),
                            child: Text(
                              'Credits',
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 204,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.cast?.length ?? 0,
                              itemBuilder: (context, index) {
                                final name = snapshot.data?.cast?[index].name !=
                                        null
                                    ? 'credits_${snapshot.data?.cast?[index].name}'
                                    : 'credits_${snapshot.data?.cast?[index].id}';
                                return PosterCard(
                                  item: TMDBResults.fromCredits(
                                    snapshot.data?.cast?[index],
                                  ),
                                  index: index,
                                  listName: name,
                                  extraLine: true,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String safeString(String? text) {
    if (text == null) {
      return '';
    }
    return text;
  }

  formatRating(double? rating) {
    if (rating != null) {
      return rating;
    }

    return 0.0;
  }

  formatString(TMDBDetail? data) {
    if (data == null) {
      return '';
    }

    var date;

    if (data.releaseDate != null && data.releaseDate != "") {
      date = DateTime.parse(data.releaseDate!).year.toString();
    } else {
      date = '';
    }

    final vote = data.voteAverage != null ? data.voteAverage.toString() : '';

    final runtime = data.runtime ?? 0;
    var company = '';

    if (data.companies != null && data.companies!.isNotEmpty) {
      company = data.companies![0].name ?? '';
    }

    if (runtime > 60) {
      return '$date  •  ${runtime ~/ 60}h ${runtime % 60}m  •  $company';
    }

    return '$date  •  $runtime min  •  $company';
  }

  resolveMediaType(String? type, int? gender) {
    switch (type) {
      case 'tv':
        return 'TV Series';
      case 'person':
        return gender == 1 ? 'Actress' : 'Actor';
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

  /// Some Series have a Season 0, aka Specials
  findSeason(int number) {
    if (content.seasons == null) {
      return number - 1;
    }

    final length = content.seasons?.length ?? 0;
    final lastSeason = content.seasons?.last.seasonNumber ?? 0;

    if (length == lastSeason + 1) {
      return number;
    }

    return number - 1;
  }
}
