import 'dart:developer';

import 'package:flutter/material.dart';

class AnimatedSearch extends StatefulWidget {
  const AnimatedSearch({Key? key, required this.searchTextController})
      : super(key: key);

  /// TextEditingController from parent class, so we can take
  /// actions there.
  final TextEditingController searchTextController;

  @override
  State<StatefulWidget> createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch> {
  /// Whether the Search Bar is in Focus (In use).
  bool inFocus = true;

  /// TextEditingController from parent class, so we can take
  /// actions there.
  late TextEditingController searchTextController;

  /// The Prefix Widget to use on the search bar.
  Widget? prefix;

  /// The hint text to display on the search bar.
  String? hint = '';

  /// Color of the search bar.
  Color searchColor = const Color.fromARGB(255, 244, 241, 249);

  /// Search icon to be used as prefix, when search bar is not
  /// in focus.
  Widget searchIcon = const Padding(
    padding: EdgeInsets.only(left: 12, right: 16),
    child: Icon(
      Icons.search,
      color: Colors.black,
      size: 35,
    ),
  );

  /// Chevron icon to be used as prefix, when search var is
  /// in focus.
  late Widget chevronIcon;

  /// TextStyle of hint text and input text of search bar.
  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  /// Method to performing some actions when search bar is
  /// dismissed.
  void dismissSearch() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      inFocus = false;
      searchTextController.clear();
      prefix = searchIcon;
      hint = 'TV Series, Movies, or Actors';
    }
  }

  @override
  void initState() {
    log('Animated Search Bar: InitState');

    searchTextController = widget.searchTextController;
    chevronIcon = Padding(
      padding: const EdgeInsets.only(left: 8, right: 12),
      child: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: 35,
        ),
        onPressed: () {
          dismissSearch();
          setState(() {});
        },
      ),
    );
    prefix = chevronIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Animated Search Bar: Build');

    return AnimatedContainer(
      height: inFocus ? 62 : 50,
      padding: inFocus ? EdgeInsets.zero : const EdgeInsets.all(4),
      margin: inFocus
          ? EdgeInsets.zero
          : const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: 8,
            ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: searchColor,
        borderRadius:
            inFocus ? null : const BorderRadius.all(Radius.circular(8)),
      ),
      child: TextField(
        onTap: () => {
          log('Animated Search Bar: TextField Tapped'),
          inFocus = true,
          hint = '',
          prefix = chevronIcon,
        },
        autofocus: true,
        expands: true,
        maxLines: null,
        controller: searchTextController,
        textAlignVertical: TextAlignVertical.center,
        style: textStyle,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: prefix,
          fillColor: searchColor,
          filled: true,
          hintStyle: textStyle,
        ),
      ),
    );
  }
}
