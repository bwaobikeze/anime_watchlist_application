const String getTopAnimeQuery = '''
  query {
    Page {
      media(type: ANIME, status: RELEASING , season: WINTER) {
        id
        title {
          english
          romaji
        }
        coverImage {
          large
        }
        description
         streamingEpisodes {
        title
        thumbnail
        url
        site
      }
      }
    }
  }
''';

const String getLatestAnimeQuery = '''
  query {
    Page {
      media(type: ANIME, sort: START_DATE_DESC) {
        id
        title {
          english
          romaji
        }
        coverImage {
          large
        }
        description
      }
    }
  }
''';

const String getCurrentlyWatchingQuery = '''
  query {
    Page {
      mediaList(userId: 6630889, status: CURRENT, type: ANIME) {
        media {
          id
          title {
            english
            romaji
          }
          coverImage {
            large
          }
          description
        }
      }
    }
  }
''';

const String getCurrentUserQuery = '''
  query {
    Viewer {
      id
      name
      avatar {
        large
      }
    }
  }
''';

//   //   final QueryResult result = await client.value.query(options);
//   //   if (result.hasException) {
//   //     throw Exception('Failed to load user: ${result.exception.toString()}');
//   //   }
//   //   print(result.data);
//   //   final List<dynamic> media = result.data!['Page']['media'];
//   //   if (media.isNotEmpty) {
//   //     return media.map((e) => AnimeCoverTile.fromJson(e)).toList();
//   //   } else {
//   //     throw Exception('No anime data found');
//   //   }
//   // }