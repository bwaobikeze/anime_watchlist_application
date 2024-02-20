import 'package:anime_watchlist_app/view/browse_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth.dart';
import 'login_page.dart';
import 'calender_page.dart';
import 'anime_library_page.dart';

class HomeScreen extends StatelessWidget {
  final String _user = FirebaseAuth.instance.currentUser!.uid;
  HomeScreen({Key? key, User? user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: ElevatedButton(
          onPressed: () {
            FieAuth fieAuth = FieAuth();
            fieAuth.signout();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text('Logout'),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          const Text('Welcome to the Anime Watchlist App'),
          Text(_user)
        ]),
      ),
    );
  }
}

class AppNavigationBar extends StatefulWidget {

 AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    calenderPage(),
    animeLibraryPage(),
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
      NavigationDestination(icon: Icon(Icons.home_outlined), label:'Home'),
      NavigationDestination(icon: Icon(Icons.library_books_outlined), label: 'Library'),
      NavigationDestination(icon: Icon(Icons.calendar_view_month_outlined), label: 'Calendar'),
      NavigationDestination(icon: Icon(Icons.search_outlined), label: 'Discover'),
    ]),
    );
    
  }
}