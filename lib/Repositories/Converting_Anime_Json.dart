import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/anime_cover_tile.dart';
import '../models/Streaming_Episodes_model.dart';

List<AnimeCoverTile> convertToAnimeCoverTile(QueryResult result) {
  List<dynamic> animes;
  if (result.data?['Page']['media'] != null) {
    animes = result.data?['Page']['media'];
  } else {
    animes = (result.data?['Page']['mediaList'] as List<dynamic>?)
            ?.map((item) => item['media'])
            .toList() ??
        [];
  }

  return animes.map((animeData) {
    var streamingEpisodesData =
        animeData['streamingEpisodes'] as List<dynamic>?;
    List<streamingEpisodes>? streamingEpisodesList;
    if (streamingEpisodesData != null) {
      streamingEpisodesList = streamingEpisodesData
          .map((episodeData) => streamingEpisodes.fromJson(episodeData))
          .toList();
    }

    return AnimeCoverTile(
      title: animeData['title']['english'],
      japtitle: animeData['title']['romaji'],
      cover: animeData['coverImage']['large'],
       extraLargeCover:  animeData['coverImage']['extraLarge'],
      rating: animeData['averageScore'],
      numOfEpisodes: animeData['episodes'],
      id: animeData['id'],
      description: animeData['description'],
      listOfEpisodes: streamingEpisodesList,
    );
  }).toList();
}
