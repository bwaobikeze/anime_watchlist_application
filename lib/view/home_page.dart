import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../repositories/firebase_auth.dart';
import 'login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../repositories/aniList_API_data.dart';
import '../models/anime_cover_tile.dart';
import '../view/anime_library_page.dart';
import '../repositories/anilist_Oauth.dart';
import '../main.dart';

// class animeCards extends StatelessWidget {
//   AnimeCoverTile animeCoverinfo;
//   animeCards({super.key, required this.animeCoverinfo});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.network(
//           animeCoverinfo!.cover,
//           fit: BoxFit.cover,
//           height: 150.0,
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Text(animeCoverinfo.title ?? animeCoverinfo.japtitle,
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ))
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

// class RecievingAnimeCover extends StatelessWidget {
//   const RecievingAnimeCover({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<AnimeCoverTile>>(
//       future: AniListAPI().getAnimeList(),
//       builder:
//           (BuildContext context, AsyncSnapshot<List<AnimeCoverTile>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           print(snapshot.error);
//           return Text('Error: ${snapshot.error}');
//         } else if (snapshot.hasData) {
//           List<AnimeCoverTile> animeList = snapshot.data!;
//           List<Widget> AnimeCards =
//               animeList.map((e) => animeCards(animeCoverinfo: e)).toList();
//           return CarouselSlider(
//               items: AnimeCards,
//               options: CarouselOptions(viewportFraction: 0.4));
//         } else {
//           return Text('No data');
//         }
//       },
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                AnlistAuth.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                       AnimeWatchlistApp(), // Replace HomeScreen() with your actual home screen widget
                  ),
                );
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Query(options: QueryOptions(document: gql()), builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {
          
        })
      ),
    );
  }
}
