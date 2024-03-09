import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/anime_cover_tile.dart';

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

    return animes.map((e) => AnimeCoverTile.fromJson(e)).toList();
  }
