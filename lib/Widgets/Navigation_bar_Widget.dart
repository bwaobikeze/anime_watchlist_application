import 'package:flutter/material.dart';
import '../view/home_page.dart';
import '../view/calender_page.dart';
import '../view/anime_library_page.dart';
import '../view/browse_page.dart';


class AppNavigationBar extends StatefulWidget {
  AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    animeLibraryPage(),
    calenderPage(),
    BrowsePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedIndex: _selectedIndex,
          destinations: const <Widget>[
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.library_books_outlined), label: 'Library'),
            NavigationDestination(
                icon: Icon(Icons.calendar_view_month_outlined),
                label: 'Calendar'),
            NavigationDestination(
                icon: Icon(Icons.search_outlined), label: 'Discover'),
          ]),
    );
  }
}