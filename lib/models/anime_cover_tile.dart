import './Streaming_Episodes_model.dart';

class AnimeCoverTile {
  String? title;
  String japtitle;
  String cover;
  int id;
  // String rating;
  String? description;
  // List<streamingEpisodes>? listOfEpisodes;
  AnimeCoverTile(
      {required this.title,
      required this.japtitle,
      required this.cover,
      required this.id,
      // this.listOfEpisodes,
      required this.description});
  factory AnimeCoverTile.fromJson(Map<String, dynamic> json) {
    return AnimeCoverTile(
        title: json['title']['english'],
        japtitle: json['title']['romaji'],
        cover: json['coverImage']['large'],
        id: json['id'],
        //listOfEpisodes: json['averageScore'].toString(),
        description: json['description']);
  }
}
