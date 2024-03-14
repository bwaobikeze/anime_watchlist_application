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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['email'] = this.email;
  //   data['phone'] = this.phone;
  //   data['address'] = this.address;
  //   data['password'] = this.password;
  //   data['role'] = this.role;
  //   data['status'] = this.status;
  //   data['created_at'] = this.created_at;
  //   data['updated_at'] = this.updated_at;
  //   return data;
  // }
}
