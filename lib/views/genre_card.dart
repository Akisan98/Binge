import 'package:binge/models/genres.dart';
import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({Key? key, required this.genre}) : super(key: key);

  final Genres? genre;

  @override
  Widget build(BuildContext context) {
    return Text(genre?.name ?? '');
  }
}
