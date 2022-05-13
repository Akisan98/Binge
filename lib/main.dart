import 'dart:developer';

import 'package:binge/models/genres.dart';
import 'package:binge/pages/navigation_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'enums/media_type.dart';
import 'models/db/db_season.dart';
import 'models/db/media_content.dart';
import 'models/tv/episode_to_air.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MediaContentAdapter());
  Hive.registerAdapter(DBSeasonsAdapter());
  Hive.registerAdapter(GenresAdapter());
  Hive.registerAdapter(EpisodeToAirAdapter());
  Hive.registerAdapter(MediaTypeAdapter());
  var box = await Hive.openBox<MediaContent>('myBox');
  //log(box.length.toString());
  await dotenv.load();
  runApp(const Binge());
}

class Binge extends StatelessWidget {
  const Binge({Key? key}) : super(key: key);

  final Color purple = const Color.fromARGB(255, 88, 14, 247);
  final Color white = const Color.fromARGB(255, 255, 255, 255);
  final Color black = const Color.fromARGB(255, 0, 0, 0);

  final Color dark = const Color.fromARGB(255, 27, 28, 33);
  final Color light = const Color.fromARGB(255, 238, 204, 215);

  final TextStyle button = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          // Light Theme
          brightness: Brightness.light,
          backgroundColor: light,
          primaryColor: purple,
          splashColor: Colors.black,
          colorScheme: ColorScheme.fromSeed(
            seedColor: purple,
            secondary: white,
            tertiary: dark,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: purple,
              minimumSize: const Size.fromHeight(56),
              textStyle: button,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textTheme: TextTheme(
            button: button,
            overline: TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ), // button 2
            headline1: TextStyle(
              color: black,
              fontSize: 48,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          // Dark Theme
          backgroundColor: dark,
          brightness: Brightness.dark,

          primaryColor: purple,
          colorScheme: ColorScheme.fromSeed(
            seedColor: purple,
            secondary: dark,
            tertiary: white,
            brightness: Brightness.dark,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: purple,
              minimumSize: const Size.fromHeight(56),
              textStyle: button,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textTheme: TextTheme(
            button: button,
            overline: TextStyle(
              color: purple,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ), // button 2
            headline1: TextStyle(
              color: white,
              fontSize: 48,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: NavigationTest(),
      );
}
