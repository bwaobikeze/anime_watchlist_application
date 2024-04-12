import '../models/Current_Anlist_user_model.dart';

const String getTopAnimeQuery = '''
  query {
    Page {
      media(type: ANIME, status: RELEASING , season: SPRING) {
        id
        title {
          english
          romaji
        }
        coverImage {
          large
          extraLarge
        }
        description
        episodes
        averageScore
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
          extraLarge
        }
        description
        episodes
        averageScore
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

String getCurrentlyWatchingQuery = '''
  query getuserCurrentWatching(\$id: Int) {
    Page {
      mediaList(userId: \$id , status: CURRENT, type: ANIME) {
        media {
          id
          title {
            english
            romaji
          }
          coverImage {
            large
            extraLarge
          }
          description
          episodes
          averageScore
       streamingEpisodes {
        title
        thumbnail
        url
        site
      }
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

const String getSearchedAnime = '''
  query(\$animeItem: String) {
    Page {
      media(type: ANIME, search:\$animeItem) {
        id
        title {
          english
          romaji
        }
        coverImage {
          large
          extraLarge
        }
        description
        episodes
        averageScore
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

const getCurrentpopularAnime = '''
query anime {
  Page(page: 1, perPage: 10) {
    media(type: ANIME, sort: POPULARITY_DESC) {
      id
      title {
        english
        romaji
      }
      coverImage {
        large
        extraLarge
      }
      description
      episodes
      averageScore
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

// getting user current anime list modding
const getCurrentUserAnimeList = '''
  query getCurrentUserWatching(\$id: Int) {
    Page {
      mediaList(userId: \$id , type: ANIME) {
        media {
          id
          title {
            english
            romaji
          }
          coverImage {
            large
            extraLarge
          }
          description
          episodes
          averageScore
       streamingEpisodes {
        title
        thumbnail
        url
        site
      }
        }
      }
    }
  }

''';