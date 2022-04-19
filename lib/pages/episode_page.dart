import 'package:flutter/material.dart';
import '../models/db/media_content.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({Key? key, required this.season}) : super(key: key);

  final DBSeasons season;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [Text(season.name ?? '')],
            ),
          ),
        ),
      );
}
