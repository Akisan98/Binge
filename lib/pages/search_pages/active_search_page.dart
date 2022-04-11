import 'dart:async';
import 'dart:developer';

import 'package:binge/models/tmdb_response.dart';
import 'package:binge/services/tmdb_service.dart';
import 'package:binge/views/list_card.dart';
import 'package:binge/views/search_bar/animated_search.dart';
import 'package:binge/views/search_history.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/transformers.dart';

class ActiveSearchPage extends StatefulWidget {
  const ActiveSearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActiveSearchPageState();
}

class _ActiveSearchPageState extends State<ActiveSearchPage> {
  TextEditingController searchText = TextEditingController();
  final StreamController<String> _controller =
      StreamController<String>.broadcast();
  late Stream<String> userTyped = _controller.stream;
  String liveQuery = '';
  TMDBService tmdb = TMDBService();

  dismissSearch() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _printLatestValue() {
    log('Second text field: ${searchText.text}');
    _controller.add(searchText.text);
    //liveQuery = searchText.text;
  }

  @override
  void initState() {
    searchText.addListener(_printLatestValue);
    super.initState();
  }

  @override
  void dispose() {
    searchText.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Active Search Page: Build");

    return GestureDetector(
      onTap: () {
        log("Active Search Page: GestureDetector Tapped");
        dismissSearch();
      },
      onPanDown: (_) {
        log("Active Search Page: GestureDetector Swiped");
        dismissSearch();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AnimatedSearch(
                // TODO: Isolate State from parent
                key: const Key("1"),
                // Need the key, else IconBtn in Prefix won't work if TextField is out of focus
                searchTextController: searchText,
              ),
              StreamBuilder<String>(
                initialData: '',
                stream:
                    userTyped.debounceTime(const Duration(milliseconds: 500)),
                builder: (builder, snapshot) {
                  log("StreamBuilder" + snapshot.data!.toString());
                  return Expanded(
                    child: Center(
                      child: snapshot.data! != ''
                          ? FutureBuilder<TMDBResponse>(
                              future: tmdb.search(snapshot.data!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount:
                                        snapshot.data?.results?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: 170,
                                        child: ListCard(
                                          item: snapshot.data!.results![index],
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            )
                          : const SearchHistory(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
