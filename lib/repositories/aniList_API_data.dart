import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:anime_watchlist_app/models/anime_cover_tile.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AniListAPI {
  static final HttpLink httpLink = HttpLink(
    'https://graphql.anilist.co',
  );

  static final ValueNotifier<GraphQLClient> client =
      ValueNotifier<GraphQLClient>(GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ));

  Future<List<AnimeCoverTile>> getAnimeList() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        r'''
        query {
          Page(page: 1, perPage: 7) {
            media(type: ANIME) {
              id
              title {
                romaji
                english
              }
              coverImage {
                large
              }
              description
              averageScore
            }
          }
        }
        ''',
      ),
    );
    final QueryResult result = await client.value.query(options);
    if (result.hasException) {
      throw Exception('Failed to load user: ${result.exception.toString()}');
    }
    print(result.data);
    final List<dynamic> media = result.data!['Page']['media'];
    if (media.isNotEmpty) {
      return media.map((e) => AnimeCoverTile.fromJson(e)).toList();
    } else {
      throw Exception('No anime data found');
    }
  }
}
