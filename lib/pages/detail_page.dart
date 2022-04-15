import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:binge/models/tmdb/tmdb_detail.dart';
import 'package:binge/models/tmdb/tmdb_result.dart';
import 'package:binge/services/tmdb_service.dart';
import 'package:binge/utils/utils.dart';
import 'package:binge/views/poster_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.item,
    required this.heroKey,
  }) : super(key: key);

  final TMDBResults item;
  final String heroKey;
  static Utils utils = Utils();
  static TMDBService tmdb = TMDBService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: heroKey,
                child: PosterImage(
                  scaleFactor: MediaQuery.of(context).size.width / 92,
                  imagePath: item.posterPath,
                  hero: true,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           SizedBox(
              //             child: AutoSizeText(
              //               item.name ?? '',
              //               maxLines: 2,
              //               textScaleFactor: 2,
              //               style: const TextStyle(fontWeight: FontWeight.bold),
              //               textAlign: TextAlign.start,
              //             ),
              //             width: MediaQuery.of(context).size.width - 100,
              //           ),
              //         ],
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(top: 16),
              //         child: Text(resolveYear(item.firstAirDate)),
              //       ),
              //     ],
              //   ),
              // ),
              FutureBuilder<TMDBDetail>(
                future: tmdb.getDetails(item.mediaType, item.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    log(snapshot.data!.toString());
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                child: AutoSizeText(
                                  item.name ?? '',
                                  maxLines: 2,
                                  textScaleFactor: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                width: MediaQuery.of(context).size.width - 100,
                              ),
                            ],
                          ),
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
                                  text: formatRating(snapshot.data?.voteAverage)
                                      .toString(),
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
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(formatString(snapshot.data)),
                          ),
                          Text(snapshot.data!.genres!.first.name!),
                          Text(snapshot.data!.toJson().toString()),
                        ],
                      ),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
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

    if (data.releaseDate != null) {
      date = DateTime.parse(data.releaseDate!).year.toString();
    } else {
      date = '';
    }

    var vote = data.voteAverage != null ? data.voteAverage.toString() : '';

    var runtime = data.runtime?.toString() ?? '';
    var company = '';

    if (data.companies != null && data.companies!.isNotEmpty) {
      company = data.companies![0].name ?? '';
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
}
