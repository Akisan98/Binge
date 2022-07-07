import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'enums/media_type.dart';
import 'models/db/db_season.dart';
import 'models/db/media_content.dart';
import 'models/genres.dart';
import 'models/tv/episode_to_air.dart';
import 'pages/onboarding_page.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Future<void> main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(MediaContentAdapter())
    ..registerAdapter(DBSeasonsAdapter())
    ..registerAdapter(GenresAdapter())
    ..registerAdapter(EpisodeToAirAdapter())
    ..registerAdapter(MediaTypeAdapter());
  await Hive.openBox<MediaContent>('myBox');
  WidgetsFlutterBinding.ensureInitialized();

  // TMP Fix
  // https://github.com/flutter/flutter/issues/101007
  // https://github.com/flutter/flutter/pull/104405
  Future.delayed(const Duration(milliseconds: 500), () {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(const Binge()));
  });
}

class Binge extends StatelessWidget {
  const Binge({Key? key}) : super(key: key);

  final Color purple = const Color.fromARGB(255, 88, 14, 247);
  final Color white = const Color.fromARGB(255, 255, 255, 255);
  final Color black = const Color.fromARGB(255, 0, 0, 0);

  final Color dark = const Color.fromARGB(255, 27, 28, 33);
  final Color light = const Color.fromARGB(255, 241, 234, 242);

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
          bottomAppBarColor: light,
          //splashColor: Colors.black,
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
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: light,
            indicatorColor: Colors.purple[800]?.withOpacity(0.5),
            iconTheme: MaterialStateProperty.all(
              IconThemeData(
                  color: Theme.of(context).textTheme.overline?.color ??
                      Colors.white,
              ),
            ),
            labelTextStyle:
                MaterialStateProperty.all(Theme.of(context).textTheme.overline),
          ),
          textTheme: TextTheme(
            button: button,
            overline: TextStyle(
              color: black,
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
          bottomAppBarColor: dark,
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.grey[800],
            indicatorColor: Colors.purple[800]?.withOpacity(0.5),
            iconTheme: MaterialStateProperty.all(
              const IconThemeData(color: Colors.white),
            ),
            labelTextStyle:
                MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          ),
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
              color: white,
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
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        home: const OnboardingPage(),
      );
}
