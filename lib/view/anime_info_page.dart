import 'dart:async';
//import 'package:sheet/sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/anime_cover_tile.dart';
import '../models/Streaming_Episodes_model.dart';
import '../Repositories/removing_html_From_String.dart';

class animeInfoPage extends StatelessWidget {
  AnimeCoverTile anime;
  animeInfoPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Image.network(
              anime.extraLargeCover ?? anime.cover,
              fit: BoxFit.cover,
            ),
          ),
          DraggableScrollableSheet(
              builder: (BuildContext context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(9),
                              child: Image.network(
                                anime.cover,
                                width: 100, // Adjust the width as needed
                                height: 150, // Adjust the height as needed
                                fit: BoxFit.cover,
                              )),
                          Column(children: [
                            Container(
                              width: 200,
                              child: Text(
                                anime.title ?? anime.japtitle,
                                style: TextStyle(fontSize: 20),
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                              ),
                            ),
                            Text(
                              "${anime.numOfEpisodes ?? 0} Episodes",
                              style: TextStyle(fontSize: 10),
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                            ),
                            OutlinedButton(
                                style: const ButtonStyle(),
                                onPressed: () {},
                                child: const Text("Add"))
                          ])
                        ],
                      ),
                      SizedBox(
                        height: 500,
                        child: animeInfoTabBar(
                          animeOverview: anime.description,
                          animeEpisodes: anime.listOfEpisodes ?? [],
                        ),
                      )
                    ],
                  )),
            );
          })
        ],
      ),
    );
  }
}

class episodeListView extends StatelessWidget {
  final List<streamingEpisodes> listOfCurrentEpisodes;
  const episodeListView({super.key, required this.listOfCurrentEpisodes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: listOfCurrentEpisodes.isEmpty
            ? const Center(
                child: Text("Sorry, no Streaming Episodes Available"))
            : ListView.builder(
                itemCount: listOfCurrentEpisodes.length,
                itemBuilder: (context, Index) {
                  return ListTile(
                    onTap: () {
                      launchUrl(
                          Uri.parse(listOfCurrentEpisodes[Index].episodeUrl!));
                    },
                    leading: Image.network(
                        listOfCurrentEpisodes[Index].thumbnail ??
                            "no Episode Data"),
                    title: Text(listOfCurrentEpisodes[Index].titleOfEpisode ??
                        'no title information'),
                  );
                }));
  }
}

class animeInfoTabBar extends StatelessWidget {
  List<streamingEpisodes>? animeEpisodes;
  String? animeOverview;

  animeInfoTabBar({super.key, this.animeEpisodes, this.animeOverview});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Review'),
              Tab(text: 'List of Episodes'),
            ],
          ),
          Expanded(
            child: Container(
              // Wrap the TabBarView in a Container if needed
              child: TabBarView(
                children: [
                  Text(removeHtmlTags(
                      animeOverview ?? 'No description for this anime')),
                  Center(child: Text('Content of Tab 2')),
                  episodeListView(listOfCurrentEpisodes: animeEpisodes ?? []),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void addAnimeToList() {
  
}
