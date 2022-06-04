import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EpisodeSkeleton extends StatelessWidget {
  const EpisodeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey[700]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                height: 24,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  color: Colors.white,
                  height: 16,
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  color: Colors.white,
                  height: 16,
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  color: Colors.white,
                  height: 24,
                  width: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  color: Colors.white,
                  height: 16,
                  width: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  color: Colors.white,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: Container(
                  color: Colors.white,
                  height: 169,
                ),
              ),
            ],
          ),
        ),
      );
}
