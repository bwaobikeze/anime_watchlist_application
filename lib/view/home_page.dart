import 'package:anime_watchlist_app/models/Current_Anlist_user_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
////import '../firbase/firebase_auth.dart';
import 'login_page.dart';
import '../Repositories/Converting_Anime_Json.dart';
import '../Anilist_GraphQL/anilist_Query_Strings.dart';
import '../models/anime_cover_tile.dart';
import '../view/anime_info_page.dart';
import '../Anilist_GraphQL/anilist_Oauth.dart';
import '../models/hivestore_persist_data.dart';

class HomeScreen extends StatelessWidget {
  final homeuserStore = UserHiveStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Getuser(),
          IconButton(
              onPressed: () {
                AnlistAuth.logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Auto-scrolling carousel of anime covers
            // Replace this with your carousel implementation
            Container(
              height: 200,
              width: 500, // Adjust the height as needed
              child:
                  getPopularanime(), // Replace Placeholder with your carousel widget
            ),
            // Top anime row
            AnimeRow(title: 'This Season', query: getTopAnimeQuery),
            // Latest anime row
            AnimeRow(title: 'Latest Anime', query: getLatestAnimeQuery),
            // Currently watching anime row
            AnimeRow(
              title: 'Currently Watching',
              query: getCurrentlyWatchingQuery,
              variable: homeuserStore.loadUser().id,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimeRow extends StatelessWidget {
  final String title;
  final String query;
  int? variable;

  AnimeRow({required this.title, required this.query, this.variable});

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
          options:
              QueryOptions(document: gql(query), variables: {'id': variable}),
          builder: (QueryResult result,
              {Refetch? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              print(result.exception.toString());
              return Text('Error: ${result.exception.toString()}');
            }

            if (result.isLoading) {
              return CircularProgressIndicator();
            }
            List<AnimeCoverTile> animeCoverList =
                convertToAnimeCoverTile(result);

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: animeCoverList
                    .map((anime) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => animeInfoPage(anime: anime),
                            ),
                          );
                          // print(anime.id);
                          // print(anime.listOfEpisodes?[0].episodeUrl);
                          // print(anime.listOfEpisodes?[0].titleOfEpisode);
                          // print(anime.listOfEpisodes?[0].thumbnail);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                anime.cover,
                                width: 100, // Adjust the width as needed
                                height: 150, // Adjust the height as needed
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 100,
                                child: Text(
                                  anime.title ?? anime.japtitle,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                ),
                              )
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
  final userStore = UserHiveStore();
  Getuser({super.key});

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
        currentUser authUser = currentUser.fromJson(user);
        userStore.saveUser(authUser);
        return CircleAvatar(
          backgroundImage: NetworkImage(authUser.avatar),
        );
      },
    );
  }
}

class getPopularanime extends StatelessWidget {
  const getPopularanime({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getCurrentpopularAnime)),
        builder: (QueryResult result,
            {Refetch? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Text('Error: ${result.exception.toString()}');
          }

          if (result.isLoading) {
            return CircularProgressIndicator();
          }
          List<AnimeCoverTile> animeCoverList = convertToAnimeCoverTile(result);
          return CarouselSlider.builder(
              itemCount: animeCoverList.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              animeInfoPage(anime: animeCoverList[index]),
                        ),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            height: 200,
                            width: 200,
                            animeCoverList[index].cover,
                            fit: BoxFit.cover,
                          ),
                        ))); // Replace this with the actual widget you want to return
              },
              options: CarouselOptions());
        });
  }
}
