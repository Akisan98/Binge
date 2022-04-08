import 'package:binge/pages/search_pages/active_search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    "TV Series, Movie, or Actor",
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
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 244, 241, 249),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
