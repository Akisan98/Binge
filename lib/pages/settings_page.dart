import 'package:flutter/material.dart';

import '../views/my_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyAppBar(
                  title: 'Settings',
                  backBtn: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: SwitchListTile.adaptive(
                    title: const Text('One day buffer'),
                    subtitle: const Text(
                      'Adds and extra day to the count down of shows the airs on American cable TV.',
                    ),
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 48,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    'Account',
                    textScaleFactor: 1.5,
                  ),
                ),
                ListTile(
                  title: const Text('Sign in with Google'),
                  subtitle: const Text(
                    'Using your Google account with Binge allows you to take backup of your content.',
                  ),
                  onTap: () {},
                ),
                Spacer(
                  flex: 10,
                ),
                const Align(
                  child: Text(
                    'Powered by TMDb',
                  ),
                ),
                const Align(
                  child: Text(
                    'Made in Norway',
                  ),
                ),
                const Align(
                  child: Text(
                    'Akisan',
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      );
}
