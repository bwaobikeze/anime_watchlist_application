class AnimeCoverTile {
  String? title;
  String japtitle;
  String cover;
  int id;
  // String rating;
  // String description;
  AnimeCoverTile(
      {required this.title,
      required this. japtitle,
      required this.cover,
      required this.id,});
      // required this.rating,
      // required this.description});
  factory AnimeCoverTile.fromJson(Map<String, dynamic> json) {
    return AnimeCoverTile(
        title: json['title']['english'],
        japtitle: json['title']['romaji'],
        cover: json['coverImage']['large'],
        id: json['id'],);
        // rating: json['averageScore'].toString(),
        // description: json['description']);
  }
}
