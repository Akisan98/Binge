import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/tmdb/tmdb_response.dart';
import '../../models/tmdb/tmdb_result.dart';
import '../poster_card.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({Key? key, required this.apiCall, required this.header})
      : super(key: key);

  final Future<TMDBResponse> Function(int) apiCall;
  final String header;

  @override
  State<StatefulWidget> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  final PagingController<int, TMDBResults> _controller =
      PagingController<int, TMDBResults>(
    firstPageKey: 1,
    invisibleItemsThreshold: 7,
  );

  static const num _scaleFactor = 0.8;

  @override
  void initState() {
    _controller.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      log(pageKey.toString());
      final response = await widget.apiCall(pageKey);
      // log(response.toString());
      final isLastPage = response.page == response.totalPages;

      if (isLastPage) {
        _controller.appendLastPage(response.results!);
      } else {
        _controller.appendPage(response.results!, pageKey + 1);
      }
    } catch (error) {
      _controller.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: SizedBox(
          height: _scaleFactor * 206,
          child: PagedListView<int, TMDBResults>(
            scrollDirection: Axis.horizontal,
            pagingController: _controller,
            builderDelegate: PagedChildBuilderDelegate<TMDBResults>(
              itemBuilder: (context, item, index) => PosterCard(
                index: index,
                listName: widget.header,
                item: item,
                scaleFactor: _scaleFactor,
              ),
              animateTransitions: true,
            ),
          ),
        ),
      );
}
