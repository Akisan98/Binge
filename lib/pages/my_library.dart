import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/media_type.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_result.dart';
import '../views/db_content.dart';
import '../views/my_app_bar.dart';
import '../views/my_library/media_grid.dart';
import '../views/my_library/media_title.dart';
import '../views/no_content.dart';
import '../views/poster_card.dart';

class MyLibrary extends StatelessWidget {
  const MyLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ValueListenableBuilder<Box<MediaContent>>(
          valueListenable: Hive.box<MediaContent>('myBox').listenable(),
          builder: (context, box, widget) => box.values.isNotEmpty
              ? CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        child: MyAppBar(
                          title: 'Library',
                          icon: Icons.settings,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Todays(
                        db: box,
                      ),
                    ),
                    CountDown(db: box),

                    MediaTitle(
                      title: 'Returning',
                      display: findReturningShows(box).isNotEmpty,
                    ),
                    MediaGrid(
                      content: findReturningShows(box),
                      listName: 'returning',
                    ),
                    MediaTitle(
                      title: 'Canceled',
                      display: findCanceledShows(box).isNotEmpty,
                    ),
                    MediaGrid(
                      content: findCanceledShows(box),
                      listName: 'canceled',
                    ),
                    MediaTitle(
                      title: 'Released',
                      display: findReleasedMovies(box).isNotEmpty,
                    ),
                    MediaGrid(
                      content: findReleasedMovies(box),
                      listName: 'released',
                    ),
                    MediaTitle(
                      title: 'Not Released',
                      display: findNotReleasedMedia(box).isNotEmpty,
                    ),
                    MediaGrid(
                      content: findNotReleasedMedia(box),
                      listName: 'not_released',
                    ),
                  ],
                )
              : Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: MyAppBar(
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
                    ),
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
        ? SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SizedBox(
                height: 170,
                child: DBContent(
                  countDown: true,
                  item: items.elementAt(index),
                  index: index,
                ),
              ),
              childCount: items.length,
            ),
            itemExtent: 170,
          )
        : const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}

Iterable<MediaContent> findReturningShows(Box<MediaContent> db) {
  Iterable<MediaContent> returning = [];

  if (returning.isNotEmpty) {
    return returning;
  }

  return returning = db.values.where((element) {
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
}

Iterable<MediaContent> findCanceledShows(Box<MediaContent> db) {
  // Returning Series, Ended, Canceled, Released, Post Production, In Production
  Iterable<MediaContent> canceled = [];

  if (canceled.isNotEmpty) {
    return canceled;
  }

  return canceled = db.values.where((element) {
    if (element.status == 'Ended' || element.status == 'Canceled') {
      return true;
    }

    return false;
  });
}

Iterable<MediaContent> findReleasedMovies(Box<MediaContent> db) {
  // Returning Series, Ended, Canceled, Released, Post Production, In Production
  Iterable<MediaContent> released = [];

  if (released.isNotEmpty) {
    return released;
  }

  return released = db.values.where((element) {
    if (element.type == MediaType.movie &&
        element.status == 'Released' &&
        element.notificationOnly != true) {
      return true;
    }

    return false;
  });
}

Iterable<MediaContent> findNotReleasedMedia(Box<MediaContent> db) {
  // Returning Series, Ended, Canceled, Released, Post Production, In Production, Planned
  Iterable<MediaContent> notReleased = [];

  if (notReleased.isNotEmpty) {
    return notReleased;
  }

  return notReleased = db.values.where((element) {
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
}
