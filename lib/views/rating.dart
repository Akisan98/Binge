import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.rating,
    this.mini = false,
  }) : super(key: key);

  final double? rating;
  final bool mini;

  double formatRating(double? rating) {
    if (rating != null) {
      return rating;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (formatRating(rating) != 0) {
      return Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.star,
              color: Colors.amber,
              size: mini ? 20 : 28,
            ),
          ),
          RichText(
            text: TextSpan(
              text: formatRating(rating).toString(),
              style: TextStyle(
                fontSize: mini ? 16 : 22,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ' / 10.0',
                  style: TextStyle(
                    fontSize: mini ? 12 : 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: '  •  Rate',
                  style: TextStyle(
                    fontSize: mini ? 12 : 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
