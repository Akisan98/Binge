import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SeasonSkeleton extends StatelessWidget {
  const SeasonSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[700]!,
        child: Container(
          color: Colors.white,
          height: 28,
          width: 100,
        ),
      );
}
