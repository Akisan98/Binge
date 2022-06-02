import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HeaderSkeleton extends StatelessWidget {
  const HeaderSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[700]!,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                height: 32,
                width: MediaQuery.of(context).size.width - 80,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  color: Colors.white,
                  height: 28,
                  width: MediaQuery.of(context).size.width * .5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  color: Colors.white,
                  height: 16,
                  width: MediaQuery.of(context).size.width * .6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  color: Colors.white,
                  height: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Container(
                  color: Colors.white,
                  height: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  color: Colors.white,
                  height: 200,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 24),
              //   child: Container(
              //     color: Colors.white,
              //     height: 24,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 16),
              //   child: Container(
              //     color: Colors.white,
              //     height: 24,
              //   ),
              // ),
            ],
          ),
        ),
      );
}
