import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/media_type.dart';
import '../models/db/db_season.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_credit.dart';
import '../models/tmdb/tmdb_detail.dart';
import '../models/tmdb/tmdb_result.dart';
import '../models/tv/episode_to_air.dart';
import '../services/tmdb_service.dart';
import '../utils/utils.dart';
import '../views/genre_card.dart';
import '../views/poster_card.dart';
import '../views/rating.dart';
import '../views/season_list.dart';
import '../views/tmdb_image.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.item,
    this.heroKey,
  }) : super(key: key);

  final TMDBResults item;
  final String? heroKey;

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  late TMDBResults item;
  late String? heroKey;
  static TMDBService tmdb = TMDBService();

  static late MediaContent content;
  late Box<MediaContent> box;
  bool isSaved = false;

  @override
  void initState() {
    setupDB();
    item = widget.item;
    heroKey = widget.heroKey;
    super.initState();
  }

  setupDB() async {
    box = Hive.box('myBox');
  }

  MediaContent? readEntry() => box.get('${item.mediaType}_${item.id}');

  void createEntry(MediaContent content) async {
    if (content.type == MediaType.tvSeries) {
      var next = resolveNextEpisode(content);
      if (next != null) {
        content.nextToWatch = await next;
      }
    }
    if (content.type == MediaType.movie && isNonReleasedMovie()) {
      content.notificationOnly = true;
    }
    log(item.toString());
    log(item.toString());
    log('${item.mediaType}_${item.id}');
    box.put('${item.mediaType}_${item.id}', content);
  }

  void deleteEntry() {
    box.delete('${item.mediaType}_${item.id}');
  }

  bool isNonReleasedMovie() {
    if (content.type != MediaType.movie) {
      return false;
    }

    DateTime release = DateTime(2099);
    if (content.nextRelease != null && content.nextRelease != '') {
      release = DateTime.parse(content.nextRelease ?? '2099-01-01');
    }
    return DateTime.now().difference(release).inDays < 0;
  }

  Future<EpisodeToAir?> resolveNextEpisode(MediaContent content) async {
    final seasonLength = content.seasons?.last.seasonNumber ?? 0;

    for (var season
        in content.seasons?.reversed ?? List<DBSeasons>.empty().reversed) {
      if (season.episodesSeen != 0) {
        if (season.episodesSeen == season.episodes) {
          if (content.seasons!.length > content.seasons!.indexOf(season) + 1) {
            log('S: ${(content.seasons!.indexOf(season) + 1)} E: 1');
            return tmdb.getTVSeason2(
                item.id ?? 0, content.seasons!.indexOf(season) + 1, 1);
          }

          log('No New Episodes');
          return null;
        } else {
          final episodes = season.episodes ?? 0;

          for (var episodeIndex = episodes; episodeIndex >= 1; episodeIndex--) {
            if (season.episodesSeenArray
                    ?.elementAt(episodeIndex - 1) ==
                1) {
              log('vS: ${season.seasonNumber} E: ${episodeIndex + 1}');
              return tmdb.getTVSeason2(
                  item.id ?? 0, season.seasonNumber!, episodeIndex + 1);
            }
          }
        }
      }
    }

    log('S: 1 E: 1');
    return tmdb.getTVSeason2(item.id ?? 0, 1, 1);
  }

  seasonOnPressed(int seenCount, int seasonNumber, List<int> seenArray,
      TMDBDetail? snapshot, dynamic context) {
    // log("media: " + content.toString());
    // log("snap: " + (snapshot != null ? snapshot.toString() : ''));

    if (content.title != snapshot?.title) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reopen page to make changes'),
        ),
      );
    }

    final season = content.seasons
        ?.firstWhere((element) => element.seasonNumber == seasonNumber);

    season?.episodesSeenArray = seenArray;
    season?.episodesSeen = seenCount;

    log(
      season!.episodesSeen.toString(),
    );
    createEntry(content);
  }

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
                    if (item.mediaType != 'person') {
                      final content2 = readEntry();
                      //final tmp = content;

                      // TODO: Should I Flush Cache or not?
                      // if (tmp != null) {
                      //   content = tmp;
                      // }

                      if (content2 != null) {
                        log('fg2');
                        var newContent = MediaContent.fromDetails(
                            snapshot.data, item.mediaType);

                        content =
                            Utils.combineMediaContents(content2, newContent);
                      }
                      // tmp == null &&
                      if (content2 == null) {
                        log('fg');
                        content = MediaContent.fromDetails(
                            snapshot.data, item.mediaType);
                      }
                    }
                    // log(snapshot.data!.toString());
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 80,
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
                              if (item.mediaType != 'person')
                                ValueListenableBuilder<Box<MediaContent>>(
                                  valueListenable:
                                      Hive.box<MediaContent>('myBox')
                                          .listenable(),
                                  builder: (context, box, widget) {
                                    return IconButton(
                                      onPressed: () {
                                        if (readEntry() != null) {
                                          setState(() {
                                            deleteEntry();
                                          });
                                        } else {
                                          setState(() {
                                            createEntry(content);
                                          });
                                        }
                                      },
                                      icon: Icon(readEntry() != null
                                          ? isNonReleasedMovie()
                                              ? Icons.notifications
                                              : Icons.check
                                          : isNonReleasedMovie()
                                              ? Icons.notification_add_outlined
                                              : Icons.add),
                                    );
                                  },
                                )
                              else
                                SizedBox.shrink(),
                            ],
                          ),
                          if (item.mediaType != MediaType.person.string)
                            Rating(rating: snapshot.data?.voteAverage)
                          else
                            const SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: item.mediaType != MediaType.person.string
                                ? Text(formatString(snapshot.data))
                                : Text(safeString(snapshot.data?.birthday)),
                          ),
                          if (item.mediaType != MediaType.person.string &&
                              (snapshot.data?.genres?.length ?? 0) > 0)
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
                              showId: item.id!,
                              onPressed: (int seenCount, int seasonNumber,
                                  List<int> seenArray) {
                                seasonOnPressed(seenCount, seasonNumber,
                                    seenArray, snapshot.data, context);
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
                    return snapshot.data!.cast!.isNotEmpty
                        ? Padding(
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
                                      final name = snapshot
                                                  .data?.cast?[index].name !=
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
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                item: TMDBResults.fromCredits(
                                                  snapshot.data?.cast?[index],
                                                ),
                                                heroKey: '$name$index',
                                              ),
                                            ),
                                          ).then((value) {
                                            setState(() {});
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink();
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

  String formatString(TMDBDetail? data) {
    if (data == null) {
      return '';
    }

    String date;

    if (data.releaseDate != null && data.releaseDate != '') {
      date = DateTime.parse(data.releaseDate!).year.toString();
    } else {
      date = '';
    }

    // final vote = data.voteAverage != null ? data.voteAverage.toString() : '';

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

  /// Gets year if date is present.
  String resolveYear(String? date) {
    if (!Utils.isDateEmpty(date)) {
      return '  •  ${DateTime.parse(date!).year.toString()}';
    }
    return '';
  }
}
