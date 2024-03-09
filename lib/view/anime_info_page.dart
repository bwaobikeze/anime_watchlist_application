import 'package:flutter/material.dart';
import '../models/anime_cover_tile.dart';

class animeInfoPage extends StatelessWidget {
  AnimeCoverTile anime;
  animeInfoPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 200, // Adjust the height as needed
            child: Image.network(anime.cover), // Replace Placeholder with your carousel widget
          ),
          Text(anime.title ?? anime.japtitle),
          Text(anime.description ?? '')
        ],
      ),
    );
  }
}
