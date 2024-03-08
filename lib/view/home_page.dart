import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../firbase/firebase_auth.dart';
import 'login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/anime_cover_tile.dart';
import '../view/anime_library_page.dart';
import '../main.dart';
import '../Anilist_GraphQL/anilist_Query_Strings.dart';

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
        actions: [Getuser()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Auto-scrolling carousel of anime covers
            // Replace this with your carousel implementation
            Container(
              height: 200, // Adjust the height as needed
              child:
                  Placeholder(), // Replace Placeholder with your carousel widget
            ),
            // Top anime row
            AnimeRow(title: 'Top Anime', query: getTopAnimeQuery),
            // Latest anime row
            AnimeRow(title: 'Latest Anime', query: getLatestAnimeQuery),
            // Currently watching anime row
            AnimeRow(
                title: 'Currently Watching', query: getCurrentlyWatchingQuery),
          ],
        ),
      ),
    );
  }
}

class AnimeRow extends StatelessWidget {
  final String title;
  final String query;

  AnimeRow({required this.title, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Query(
          options: QueryOptions(
            document: gql(query),
          ),
          builder: (QueryResult result,
              {Refetch? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              print(result.exception.toString());
              return Text('Error: ${result.exception.toString()}');
            }

            if (result.isLoading) {
              return CircularProgressIndicator();
            }

            final List<dynamic> animes = result.data?['Page']['media']  ?? (result.data?['Page']['mediaList'] as List<dynamic>?)?.map((item) => AnimeCoverTile.fromJson(item)).toList() ?? [];
            List <AnimeCoverTile>animeCoverList = animes.map((e) => AnimeCoverTile.fromJson(e)).toList(); // take a look and undesatnd

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: animeCoverList
                    .map((anime) =>GestureDetector( onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AnimeLibraryPage(anime: anime),
                      //   ),
                      // );
                      print(anime.id);
                    
                    },child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                anime.cover,
                                width: 100, // Adjust the width as needed
                                height: 150, // Adjust the height as needed
                                fit: BoxFit.cover,
                              ),
                              Text(
                                anime.title??
                                anime.japtitle,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ],
                          ),
                        )))
                    .toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class Getuser extends StatelessWidget {
  const Getuser({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(getCurrentUserQuery)),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          print(result.exception.toString());
          return Text('Error: ${result.exception.toString()}');
        }

        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        final Map<String, dynamic> user = result.data?['Viewer'] ?? {};

        return CircleAvatar(
          backgroundImage: NetworkImage(user['avatar']['large']),
        );
      },
    );
  }
}
