import '../models/Current_Anlist_user_model.dart';

String useridq = '';
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

const String getCurrentlyWatchingQuery = '''
  query {
    Page {
      mediaList(userId: 6657588 , status: CURRENT, type: ANIME) {
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
// 6630889
//6657588