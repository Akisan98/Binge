import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/media_type.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_result.dart';
import '../views/db_content.dart';
import '../views/poster_card.dart';

class MyLibrary extends StatelessWidget {
  const MyLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: SizedBox.expand(
          child: ValueListenableBuilder<Box<MediaContent>>(
            valueListenable: Hive.box<MediaContent>('myBox').listenable(),
            builder: (context, box, widget) => ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Todays(
                      db: box,
                    );
                  case 1:
                    return CountDown(db: box);
                  case 2:
                    return Returning(db: box);
                  case 3:
                    return Canceled(db: box);
                  case 4:
                    return SizedBox.shrink(); //Aired(db: box);
                  case 5:
                    return Released(db: box);
                  case 6:
                    return NotReleased(db: box);
                  default:
                    return const Text("This shouldn't happen...");
                }
              },
            ),
          ),
        ),
      );
}

TMDBResults toRes(MediaContent? dbContent) => TMDBResults(
      id: dbContent?.tmdbId,
      mediaType: dbContent?.type == MediaType.movie
          ? MediaType.movie.string
          : MediaType.tvSeries.string,
      posterPath: dbContent?.posterPath,
      name: dbContent?.title,
    );

class Todays extends StatelessWidget {
  const Todays({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  @override
  Widget build(BuildContext context) {
    final items = db.values.where(
      (element) =>
          (element.nextRelease != null && element.nextRelease != '') &&
          DateTime.now()
                  .difference(DateTime.parse(element.nextRelease!))
                  .inHours >=
              0 &&
          DateTime.now()
                  .difference(DateTime.parse(element.nextRelease!))
                  .inHours <=
              24,
    );

    return items.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 16),
                  child: Text(
                    'Today!',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    for (var i = 0; i < items.length; i++)
                      SizedBox(
                        height: 206,
                        child: PosterCard(
                          item: toRes(items.elementAt(i)),
                          index: i,
                          listName: 'todays',
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class CountDown extends StatelessWidget {
  const CountDown({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  @override
  Widget build(BuildContext context) {
    final items = db.values.where((element) {
      if (element.nextRelease != null && element.nextRelease != '') {
        if (DateTime.now()
                    .difference(DateTime.parse(element.nextRelease!))
                    .inDays <
                0 ||
            DateTime.now()
                    .difference(DateTime.parse(element.nextRelease!))
                    .inHours <
                0) {
          return true;
        }
        return false;
      } else {
        return false;
      }
    }).toList();
    items.sort(((a, b) {
      if (a.nextRelease == null || a.nextRelease == '') {
        return -1;
      }
      if (b.nextRelease == null || b.nextRelease == '') {
        return -1;
      }

      return a.nextRelease!.compareTo(b.nextRelease!);
    }));

    return Wrap(
      children: [
        for (var i = 0; i < items.length; i++)
          SizedBox(
            height: 170,
            child: DBContent(
              countDown: true,
              item: items.elementAt(i),
              index: i,
            ),
          ),
      ],
    );
  }
}

class Aired extends StatelessWidget {
  const Aired({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  // Returning Series, Ended, Canceled

  @override
  Widget build(BuildContext context) {
    final items = db.values.where((element) {
      if (element.nextRelease != null && element.nextRelease != '') {
        if (DateTime.now()
                .difference(DateTime.parse(element.nextRelease!))
                .inDays >
            0) {
          return true;
        }
        return false;
      }
      return true;
    });

    items.forEach((item) => log(item.toString()));

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Aired!',
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            children: [
              for (var i = 0; i < items.length; i++)
                SizedBox(
                  height: 200,
                  child: PosterCard(
                    scaleFactor: 0.8,
                    item: toRes(items.elementAt(i)),
                    index: i,
                    listName: 'aired',
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class Canceled extends StatelessWidget {
  const Canceled({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  // Returning Series, Ended, Canceled, Released, Post Production, In Production
  @override
  Widget build(BuildContext context) {
    final items = db.values.where((element) {
      if (element.status == 'Ended' || element.status == 'Canceled') {
        return true;
      }

      return false;
    });

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'canceled!',
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            children: [
              for (var i = 0; i < items.length; i++)
                SizedBox(
                  height: 200,
                  child: PosterCard(
                    scaleFactor: 0.8,
                    item: toRes(items.elementAt(i)),
                    index: i,
                    listName: 'canceled',
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class Released extends StatelessWidget {
  const Released({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  // Returning Series, Ended, Canceled, Released, Post Production, In Production
  @override
  Widget build(BuildContext context) {
    final items = db.values.where((element) {
      if (element.type == MediaType.movie &&
          element.status == 'Released' &&
          element.notificationOnly != true) {
        return true;
      }

      return false;
    });

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'released!',
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            children: [
              for (var i = 0; i < items.length; i++)
                SizedBox(
                  height: 200,
                  child: PosterCard(
                    scaleFactor: 0.8,
                    item: toRes(items.elementAt(i)),
                    index: i,
                    listName: 'released',
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class Returning extends StatelessWidget {
  const Returning({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  // Returning Series, Ended, Canceled, Released, Post Production, In Production
  @override
  Widget build(BuildContext context) {
    final items = db.values.where((element) {
      if (element.type == MediaType.tvSeries &&
          (element.nextRelease == null ||
              element.nextRelease == '' ||
              (DateTime.now()
                      .difference(
                          DateTime.parse(element.nextRelease ?? '2022-01-01'))
                      .inDays >
                  0)) &&
          element.status == 'Returning Series') {
        return true;
      }

      return false;
    });

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Returning!',
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            children: [
              for (var i = 0; i < items.length; i++)
                SizedBox(
                  height: 200,
                  child: PosterCard(
                    scaleFactor: 0.8,
                    item: toRes(items.elementAt(i)),
                    index: i,
                    listName: 'Returning',
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

class NotReleased extends StatelessWidget {
  const NotReleased({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  // Returning Series, Ended, Canceled, Released, Post Production, In Production
  @override
  Widget build(BuildContext context) {
    final items = db.values.where((element) {
      if ((element.type == MediaType.movie &&
                  (element.status == 'In Production' ||
                      element.status == 'Post Production') ||
              (element.type == MediaType.tvSeries &&
                  (element.status == 'In Production' ||
                      element.status == 'Post Production' ||
                      element.status == 'Planned'))) &&
          (element.nextRelease == null || element.nextRelease == '')) {
        return true;
      }

      return false;
    });

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Not Released!',
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            children: [
              for (var i = 0; i < items.length; i++)
                SizedBox(
                  height: 200,
                  child: PosterCard(
                    scaleFactor: 0.8,
                    item: toRes(items.elementAt(i)),
                    index: i,
                    listName: 'not_released',
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
