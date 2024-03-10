import './Streaming_Episodes_model.dart';
import './Streaming_Episodes_model.dart';

class AnimeCoverTile {
  String? title;
  String japtitle;
  String cover;
  int id;
  int? rating;
  String? description;
  int? numOfEpisodes;
  List<streamingEpisodes>? listOfEpisodes;
  AnimeCoverTile(
      {required this.title,
      required this.japtitle,
      required this.cover,
      required this.id,
      required this.rating,
      required this.numOfEpisodes,
      this.listOfEpisodes,
      required this.description});
  factory AnimeCoverTile.fromJson(Map<String, dynamic> json) {
    return AnimeCoverTile(
        title: json['title']['english'],
        japtitle: json['title']['romaji'],
        cover: json['coverImage']['large'],
        rating: json['averageScore'],
        numOfEpisodes: json['episodes'],
        id: json['id'],
        description: json['description']);
  }
}
