import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/media_type.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_result.dart';
import '../views/db_content.dart';
import '../views/my_app_bar.dart';
import '../views/no_content.dart';
import '../views/poster_card.dart';

class MyLibrary extends StatelessWidget {
  const MyLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ValueListenableBuilder<Box<MediaContent>>(
          valueListenable: Hive.box<MediaContent>('myBox').listenable(),
          builder: (context, box, widget) => box.values.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        child: const MyAppBar(
                          title: 'Library',
                          icon: Icons.settings,
                        ),
                      ),
                      Todays(
                        db: box,
                      ),
                      CountDown(db: box),
                      Returning(db: box),
                      Canceled(db: box),
                      const SizedBox.shrink(), //Aired(db: box)
                      Released(db: box), NotReleased(db: box)
                    ],
                  )
                
          )
              : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: const MyAppBar(
                          title: 'Library',
                          icon: Icons.settings,
                        ),
                      ),
                      

                    Spacer(
                      flex: 3,
                    ),
                    NoContent(
                        message:
                            'You have no content. How about starting by adding a new show or movie?',
                      ),
                    Spacer(
                      flex: 4,
                    )
                    ],
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
    final items = db.values.where((element) =>
        (element.nextRelease != null && element.nextRelease != '') &&
        DateTime.now()
                .difference(DateTime.parse(element.nextRelease!))
                .inHours >
            0 &&
        DateTime.now()
                .difference(DateTime.parse(element.nextRelease!))
                .inHours <=
            24);

    return items.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 16),
                  child: Text(
                    'Today',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 206,
                  child: ListView.builder(
                    //shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) => PosterCard(
                      item: toRes(items.elementAt(index)),
                      index: index,
                      listName: 'todays',
                    ),
                  ),
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
                    .inHours <=
                0) {
          return true;
        }
        return false;
      } else {
        return false;
      }
    }).toList();
    // ignore: cascade_invocations
    items.sort(
      (a, b) => (a.nextRelease ?? '2099-01-01')
          .compareTo(b.nextRelease ?? '2099-01-01'),
    );

    return items.isNotEmpty
        ? SizedBox(
            height: 170.0 * items.length,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) => SizedBox(
                height: 170,
                child: DBContent(
                  countDown: true,
                  item: items.elementAt(index),
                  index: index,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
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
                        DateTime.parse(element.nextRelease ?? '2022-01-01'),
                      )
                      .inDays >
                  0)) &&
          element.status == 'Returning Series') {
        return true;
      }

      return false;
    });

    return items.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 16),
                  child: Text(
                    'Returning',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 174.0 * ((items.length / 4).ceil()),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.5,
                        crossAxisCount: 4,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: 160,
                        child: PosterCard(
                          scaleFactor: 0.8,
                          item: toRes(items.elementAt(index)),
                          index: index,
                          listName: 'Returning',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
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

    return items.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 16),
                  child: Text(
                    'Canceled',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 174.0 * ((items.length / 4).ceil()),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.5,
                        crossAxisCount: 4,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) => PosterCard(
                        scaleFactor: 0.8,
                        item: toRes(items.elementAt(index)),
                        index: index,
                        listName: 'canceled',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
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

    return items.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 16),
                  child: Text(
                    'Released',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 174.0 * ((items.length / 4).ceil()),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.5,
                        crossAxisCount: 4,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) => PosterCard(
                        scaleFactor: 0.8,
                        item: toRes(items.elementAt(index)),
                        index: index,
                        listName: 'released',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class NotReleased extends StatelessWidget {
  const NotReleased({Key? key, required this.db}) : super(key: key);

  final Box<MediaContent> db;

  // Returning Series, Ended, Canceled, Released, Post Production, In Production, Planned
  Widget build(BuildContext context) {
    final items = db.values.where((element) {
      if ((element.type == MediaType.movie &&
                  (element.status == 'In Production' ||
                      element.status == 'Post Production' ||
                      element.status == 'Planned') ||
              (element.type == MediaType.tvSeries &&
                  (element.status == 'In Production' ||
                      element.status == 'Post Production' ||
                      element.status == 'Planned'))) &&
          (element.nextRelease == null || element.nextRelease == '')) {
        return true;
      }

      return false;
    });

    return items.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 32, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 16),
                  child: Text(
                    'Not Released',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 174.0 * ((items.length / 4).ceil()),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.5,
                        crossAxisCount: 4,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) => PosterCard(
                        scaleFactor: 0.8,
                        item: toRes(items.elementAt(index)),
                        index: index,
                        listName: 'not_released',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
