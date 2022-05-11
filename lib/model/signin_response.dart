class SigninResponse {
  String? email;
  String? password;
  String? id;

  SigninResponse({this.email, this.password, this.id});

  SigninResponse.fromJson(Map<String, dynamic> json) {
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
