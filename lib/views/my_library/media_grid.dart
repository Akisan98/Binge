import 'package:flutter/cupertino.dart';

import '../../enums/media_type.dart';
import '../../models/db/media_content.dart';
import '../../models/tmdb/tmdb_result.dart';
import '../poster_card.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid({Key? key, required this.content, required this.listName})
      : super(key: key);

  final Iterable<MediaContent> content;
  final String listName;

  TMDBResults toRes(MediaContent? dbContent) => TMDBResults(
        id: dbContent?.tmdbId,
        mediaType: dbContent?.type == MediaType.movie
            ? MediaType.movie.string
            : MediaType.tvSeries.string,
        posterPath: dbContent?.posterPath,
        name: dbContent?.title,
      );

  @override
  Widget build(BuildContext context) => content.isNotEmpty
      ? SliverPadding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: MediaQuery.of(context).size.aspectRatio <= 0.5
                ? (92 / 164)
                : (92 / 185),
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => PosterCard(
              scaleFactor: 0.8,
              item: toRes(content.elementAt(index)),
              index: index,
              listName: listName,
            ),
            childCount: content.length,
          ),
        ),
        )
      : const SliverToBoxAdapter(child: SizedBox.shrink());
}
