import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../firbase/firebase_auth.dart';
import 'login_page.dart';
import '../Repositories/Converting_Anime_Json.dart';
import '../Anilist_GraphQL/anilist_Query_Strings.dart';
import '../models/anime_cover_tile.dart';
import '../view/anime_info_page.dart';

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
            AnimeRow(title: 'This Season', query: getTopAnimeQuery),
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
                          print(anime.id);
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
