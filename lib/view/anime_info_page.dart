import 'dart:async';
import 'package:sheet/sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/anime_cover_tile.dart';
import '../models/Streaming_Episodes_model.dart';

class animeInfoPage extends StatelessWidget {
  AnimeCoverTile anime;
  animeInfoPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Sheet(
            initialExtent: 200,
            child: Container(color: Colors.blue[100]),
          )
        ],
      ),
      // body: Column(
      //   children: [
      //     Flexible(
      //       flex: 5,
      //       child:
      //     Container(// Adjust the height as needed
      //       child: AspectRatio(
      //         aspectRatio: 2 / 3,
      //         child: Image.network(
      //           anime.extraLargeCover ?? anime.cover,
      //           fit: BoxFit.cover,
      //         ),
      //       ), // Replace Placeholder with your carousel widget
      //     )),
      //     Text(anime.title ?? anime.japtitle),
      //     Text(anime.description ?? ''),
      //     //animeInfoTabBar(),
      //     Text("Number of episodes: ${anime.numOfEpisodes}"),
      //     Text("Score: ${anime.rating}"),
      //     // Image.network(anime.listOfEpisodes?[0].thumbnail ?? ''),
      //     episodeListView(
      //       listOfCurrentEpisodes: anime.listOfEpisodes ?? [],
      //     )
      //   ],
      // ),
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
  animeInfoTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: TabBar(tabs: [
        Tab(
          text: "Overview",
        ),
        Tab(
          text: "Review",
        ),
        Tab(
          text: "List Of Epidsodes",
        ),
      ]),
    );
  }
}
