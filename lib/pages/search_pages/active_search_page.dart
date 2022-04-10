// When pressing SearchBar

import 'dart:async';
import 'dart:developer';

import 'package:binge/views/search_bar/animated_search.dart';
import 'package:flutter/material.dart';

class ActiveSearchPage extends StatefulWidget {
  const ActiveSearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActiveSearchPageState();
}

class _ActiveSearchPageState extends State<ActiveSearchPage> {
  TextEditingController searchText = TextEditingController();
  final StreamController<bool> _controller = StreamController<bool>();
  late Stream<bool> hasTyped = _controller.stream;

  dismissSearch() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _printLatestValue() {
    log('Second text field: ${searchText.text}');
    _controller.add(searchText.text != "");
    log(hasTyped.toString());
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
              StreamBuilder<bool>(
                initialData: false,
                stream: hasTyped,
                builder: (builder, snapshot) {
                  log(snapshot.data!.toString());
                  return SearchBody(hasTyped: snapshot.data!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key, required this.hasTyped}) : super(key: key);
  final bool hasTyped;

  @override
  Widget build(BuildContext context) {
    return hasTyped ? const Text("SEARCHING!") : const Text("WRITE!!!");
  }
}
