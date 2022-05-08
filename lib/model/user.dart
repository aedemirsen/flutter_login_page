class User {
  String? email;
  String? password;
  String? id;

  User({this.email, this.password, this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['id'] = id;
    return data;
  }
}
