import 'package:flutter/material.dart';

import 'home_page.dart';
import 'navigation_test.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Privacy is a good thing!'),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationTest()),
                    );
                  },
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
