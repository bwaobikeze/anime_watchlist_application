import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Anilist_GraphQL/anilist_Query_Strings.dart';
import '../Repositories/Converting_Anime_Json.dart';
import '../models/anime_cover_tile.dart';
import '../view/anime_info_page.dart';

class BrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse'),
      ),
      body: animeSearching(),
    );
  }
}

class animeSearching extends StatefulWidget {

  animeSearching({super.key});

  @override
  State<animeSearching> createState() => _animeSearchingState();
}

class _animeSearchingState extends State<animeSearching> {
  String animeToSearch = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Container(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 172, 179, 183)),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  animeToSearch = value;
                });
                print('animeToSearch updating: ${animeToSearch}');
              },
            ),
          ),
        ),
        Query(
            options: QueryOptions(
                document: gql(getSearchedAnime),
                variables: {'animeItem': animeToSearch}),
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
              return Expanded(
                  child: ListView.builder(
                itemCount: animeCoverList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  animeInfoPage(anime: animeCoverList[index]),
                            ),
                          );
                        },
                        leading: AspectRatio(aspectRatio: 16/9 , child:  Image.network(
                          animeCoverList[index].cover,
                          fit: BoxFit.cover,
                        ),
                        ),
                        title: Text(animeCoverList[index].title ??
                            animeCoverList[index].japtitle),

                        // print(animeCoverList[index].title);
                      ));
                },
              ));
            }),
      ],
    );
  }
}
