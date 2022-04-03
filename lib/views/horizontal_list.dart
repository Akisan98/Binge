import 'package:binge/models/tmdb_response.dart';
import 'package:binge/views/poster_card.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({Key? key, required this.header, required this.future})
      : super(key: key);

  final Future<TMDBResponse> future;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 24, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              header,
              textScaleFactor: 1.5,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: future,
          builder:
              (BuildContext context, AsyncSnapshot<TMDBResponse> response) {
            switch (response.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading....');
              default:
                if (response.hasError) {
                  return Text('Error: ${response.error}');
                } else {
                  return SizedBox(
                    height: 153,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: response.data?.results?.length ?? 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return PosterCard(
                          text: response.data!.results![index],
                          scaleFactor: 0.7,
                        );
                      },
                    ),
                  );
                }
            }
          },
        ),
      ],
    );
  }
}
