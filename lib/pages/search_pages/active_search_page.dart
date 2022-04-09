// When pressing SearchBar

import 'package:binge/views/search_bar/animated_search.dart';
import 'package:flutter/material.dart';

class ActiveSearchPage extends StatefulWidget {
  const ActiveSearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActiveSearchPageState();
}

class _ActiveSearchPageState extends State<ActiveSearchPage> {
  bool inFocus = true;
  TextEditingController searchText = TextEditingController();
  TextEditingController searchText2 = TextEditingController();
  Widget? prefix;
  String? hint = '';

  Color searchColor = const Color.fromARGB(255, 244, 241, 249);

  Widget searchIcon = const Padding(
    padding: EdgeInsets.only(left: 12, right: 16),
    child: Icon(
      Icons.search,
      color: Colors.black,
      size: 35,
    ),
  );

  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  late Widget chevronIcon;

  dismissSearch() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      inFocus = false;
      searchText.clear();
      prefix = searchIcon;
      hint = 'TV Series, Movies, or Actors';
    }
  }

  @override
  void initState() {
    chevronIcon = Padding(
      padding: const EdgeInsets.only(left: 8, right: 12),
      child: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: 35,
        ),
        onPressed: () {
          setState(() {});
          dismissSearch();
        },
      ),
    );
    prefix = chevronIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dismissSearch();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AnimatedSearch(
                key: Key(
                    "1"), // Need the key, else IconBtn in Prefix won't work if TextField is out of focus
                searchTextController: searchText2,
              ),
              AnimatedContainer(
                height: inFocus ? 62 : 50,
                padding:
                    inFocus ? const EdgeInsets.all(0) : const EdgeInsets.all(4),
                margin: inFocus
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 24,
                        bottom: 8,
                      ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Center(
                  child: TextField(
                    onTap: () => {
                      inFocus = true,
                      hint = '',
                      prefix = chevronIcon,
                    },
                    autofocus: true,
                    expands: true,
                    maxLines: null,
                    controller: searchText,
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
                ),
                decoration: BoxDecoration(
                  color: searchColor,
                  borderRadius: inFocus
                      ? null
                      : const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
