import 'package:binge/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Light Theme
        brightness: Brightness.light,
        backgroundColor: light,
        primaryColor: purple,
        splashColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          secondary: dark,
          tertiary: white,
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
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: true,
      home: HomePage(),
    );
  }
}
