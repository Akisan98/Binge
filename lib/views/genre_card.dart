import 'package:flutter/material.dart';

import '../models/genres.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({Key? key, required this.genre}) : super(key: key);

  final Genres? genre;

  @override
  Widget build(BuildContext context) => Text(genre?.name ?? '');
}
