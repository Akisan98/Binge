import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key, required this.title, this.icon, this.backBtn})
      : super(key: key);

  final String title;
  final IconData? icon;
  final bool? backBtn;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 48,
          left: 8,
          right: 8,
        ),
        child: Row(
          children: [
            if (backBtn != null)
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 32,
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
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
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                ),
                icon: Icon(
                icon,
                size: 32,
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      );
}
