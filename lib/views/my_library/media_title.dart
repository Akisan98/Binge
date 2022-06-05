import 'package:flutter/material.dart';

class MediaTitle extends StatelessWidget {
  const MediaTitle(
      {Key? key, required this.display, required this.title, this.leftPadding})
      : super(key: key);

  final bool display;
  final String title;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) => display
      ? SliverPadding(
        padding: EdgeInsets.only(
            left: leftPadding != null ? leftPadding! : 22, top: 32, bottom: 16),
          sliver: SliverToBoxAdapter(
                child: Text(
                  title,
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        )
      : const SliverToBoxAdapter(child: SizedBox.shrink());
}
