import 'package:flutter/material.dart';

import '../../pages/search_pages/active_search_page.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActiveSearchPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 24, bottom: 8, right: 8),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 244, 241, 249),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'TV Series, Movies, or Actors',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
