import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'db_res.dart';
import 'home_page.dart';
import 'my_library.dart';
import 'search_pages/active_search_page.dart';

class NavigationTest extends StatefulWidget {
  const NavigationTest({Key? key}) : super(key: key);

  @override
  State<NavigationTest> createState() => _NavigationTestState();
}

class _NavigationTestState extends State<NavigationTest> {
  final PageController _pageController = PageController();
  late final AlertDialog alert;
  int _currentIndex = 0;
  late List<Widget> pages;

  void onSearchBoxTapped() {
    setState(() {
      _currentIndex = 3;
    });
    _pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 1),
      curve: Curves.decelerate,
    );
  }

  void createDialog() {
    // Dialog Action Button
    final Widget okButton = TextButton(
      child: const Text('Ok'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    final alert = AlertDialog(
      title: const Text('Try our mobile application!'),
      content: const Text(
          'This web application is only meant for testing our application.\nNote that performance will be slower compared to the mobile application.'),
      actions: [
        okButton,
      ],
    );

    // Wait & Show Dialog
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (context) => alert,
      ),
    );
  }

  @override
  void initState() {
    //_pageController = PageController();
    //_currentIndex = 0;
    pages = [
      const DBRes(),
      HomePage(onTapped: onSearchBoxTapped),
      const MyLibrary(),
      const ActiveSearchPage()
    ];

    if (kIsWeb) {
      createDialog();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: pages,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index == 3 ? 1 : index;
            });
          },
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: Theme.of(context).navigationBarTheme,
          child: NavigationBar(
            height: 60,
            //backgroundColor: Theme.of(context).bottomAppBarColor,
            animationDuration: const Duration(seconds: 1),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: _currentIndex == 3 ? 1 : _currentIndex,
            onDestinationSelected: (newIndex) {
              _pageController.animateToPage(
                newIndex,
                duration: const Duration(milliseconds: 1),
                curve: Curves.decelerate,
              );
            },
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home_filled),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.search),
                icon: Icon(Icons.search_outlined),
                label: 'Search',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.my_library_books),
                icon: Icon(Icons.my_library_books_outlined),
                label: 'My Library',
              ),
            ],
          ),
        ),
      );
}

const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);
