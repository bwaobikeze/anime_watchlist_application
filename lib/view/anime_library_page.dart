import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Anilist_GraphQL/anilist_Query_Strings.dart';
import '../Repositories/Converting_Anime_Json.dart';
import '../models/hivestore_persist_data.dart';
import '../models/anime_cover_tile.dart';
import '../view/anime_info_page.dart';

class animeLibraryPage extends StatelessWidget {
  final homeuserStore = UserHiveStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Library'),
      ),
      body: Query(
          options: QueryOptions(
              document: gql(getCurrentUserAnimeList),
              variables: {'id': homeuserStore.loadUser().id}),
          builder: (QueryResult result,
              {Refetch? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              print(result.exception.toString());
              return Text('Error: ${result.exception.toString()}');
            }

            if (result.isLoading) {
              return const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(child: CircularProgressIndicator()));
            }

            List<AnimeCoverTile> animeCoverList =
                convertToAnimeCoverTile(result);

            return animeCoverList.isEmpty
                ? const Center(child: Text("Did not get your anime List 😢"))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: animeCoverList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: AspectRatio(
                                aspectRatio: 40 / 47,
                                child: Image.network(
                                  animeCoverList[index].cover,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )),
                            title: Text(animeCoverList[index].title ??
                                animeCoverList[index].japtitle),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => animeInfoPage(
                                      anime: animeCoverList[index]),
                                ),
                              );
                            },
                          ));
                    });
          }),
    );
  }
}
