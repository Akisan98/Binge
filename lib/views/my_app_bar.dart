import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key, required this.title, this.icon}) : super(key: key);

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 48,
          left: 8,
          right: 8,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textScaleFactor: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                size: 32,
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      );
}
