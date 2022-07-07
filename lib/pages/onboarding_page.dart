import 'package:flutter/material.dart';

import '../enums/media_type.dart';
import '../models/db/db_season.dart';
import '../models/db/media_content.dart';
import '../models/tv/episode_to_air.dart';
import '../services/v1_import_service.dart';
import 'navigation_test.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 135, 32, 60),
            child: Column(
              children: [
                Text(
                  'Welcome 👋',
                  style: theme.textTheme.headline1,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 32,
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    'Binge is the app to keep track of all of your TV Shows and movies and how far you have progressed.',
                    textScaleFactor: 1.1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationTest()),
                    );
                  },
                  child: Text(
                    'Start Fresh',
                    style: theme.textTheme.button,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  onPressed: (() async {
                    await V1ImportService.convertData();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationTest()),
                    );
                  }),
                  style: ElevatedButton.styleFrom(
                    primary: theme.colorScheme.tertiary,
                  ),
                  child: Text(
                    'Keep my data',
                    style: TextStyle(
                      color: theme.brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
