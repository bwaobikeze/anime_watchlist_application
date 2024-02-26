class AnimeCoverTile {
  String title;
  String cover;
  int id;
  String rating;
  String description;
  AnimeCoverTile(
      {required this.title,
      required this.cover,
      required this.id,
      required this.rating,
      required this.description});
  factory AnimeCoverTile.fromJson(Map<String, dynamic> json) {
    return AnimeCoverTile(
        title: json['title']['english'],
        cover: json['coverImage']['large'],
        id: json['id'],
        rating: json['averageScore'].toString(),
        description: json['description']);
  }
}
