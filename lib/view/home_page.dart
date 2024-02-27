import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/firebase_auth.dart';
import 'login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../repositories/aniList_API_data.dart';
import '../models/anime_cover_tile.dart';
import '../view/anime_library_page.dart';

class HomeScreen extends StatelessWidget {
  final String _user = FirebaseAuth.instance.currentUser!.uid;
  HomeScreen({Key? key, User? user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Image.asset('assets/goku-icon-head.png'),
        backgroundColor: Colors.transparent,
        title: Center( child: Text('Home') ),
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
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    Text('Top Anime',
                    style:TextStyle(fontWeight: FontWeight.bold),),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => animeLibraryPage()));
                      },
                      child: Text('MORE'),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text('Most Wacthed',
                    style:TextStyle(fontWeight: FontWeight.bold),),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => animeLibraryPage()));
                      },
                      child: Text('MORE'),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text('Continue Adding',
                    style:TextStyle(fontWeight: FontWeight.bold),),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => animeLibraryPage()));
                      },
                      child: Text('MORE'),
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          )
        ],
      ),
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
