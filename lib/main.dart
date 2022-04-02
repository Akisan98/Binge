import 'package:flutter/material.dart';

Future<void> main() async {
  // await dotenv.load(fileName: ".env");
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
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 135, 32, 60),
            child: Column(
              children: [
                Text(
                  "Welcome 👋",
                  style: theme.textTheme.headline1,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 32,
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    "Binge is the app to keep track of all of your TV Shows and movies and how far you have progressed.",
                    textScaleFactor: 1.1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: (() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Privacy is a good thing!"),
                      ),
                    );
                  }),
                  child: Text(
                    "Let's Start!",
                    style: theme.textTheme.button,
                  ),
                ),
                // const SizedBox(
                //   height: 18,
                // ),
                // ElevatedButton(
                //   onPressed: (() {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text("No Support for web"),
                //       ),
                //     );
                //   }),
                //   child: Text(
                //     "Sign in with Trakt",
                //     style: theme.textTheme.overline,
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: theme.brightness == Brightness.light
                //         ? theme.colorScheme.secondary
                //         : theme.colorScheme.tertiary,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
