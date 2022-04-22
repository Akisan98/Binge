import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/tmdb/tmdb_result.dart';
import '../pages/detail_page.dart';

class TextCard extends StatelessWidget {
  const TextCard({Key? key, required this.item}) : super(key: key);

  final TMDBResults item;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              item: item,
            ),
          ),
        ),
        child: Text(item.name ?? ''),
      );
}
