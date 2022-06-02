import 'package:flutter/material.dart';

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
  PageController _pageController = PageController();

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

  int _currentIndex = 0;
  late List<Widget> pages;

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
