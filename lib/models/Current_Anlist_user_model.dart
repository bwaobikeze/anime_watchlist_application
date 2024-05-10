class currentUser {
  int id;
  String name;
  String avatar;


  currentUser({required this.id, required this.name, required this.avatar});

  factory currentUser.fromJson(Map<String, dynamic> json) {
    return currentUser(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar']['large'],
    );

  }

}
