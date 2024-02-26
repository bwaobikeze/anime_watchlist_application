import 'package:anime_watchlist_app/view/browse_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/firebase_auth.dart';
import 'login_page.dart';
import 'calender_page.dart';
import 'anime_library_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../repositories/aniList_API_data.dart';
import '../models/anime_cover_tile.dart';

class HomeScreen extends StatelessWidget {
  final String _user = FirebaseAuth.instance.currentUser!.uid;
  HomeScreen({Key? key, User? user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FieAuth fieAuth = FieAuth();
              fieAuth.signout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          RecievingAnimeCover()
        ],
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

class RecievingAnimeCover extends StatelessWidget {
  const RecievingAnimeCover({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AnimeCoverTile>(
      future: AniListAPI().getAnimeList(),
      builder: (BuildContext context, AsyncSnapshot<AnimeCoverTile> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView();
        } else {
          return Text('No data');
        }
      },
    );
  }
}
