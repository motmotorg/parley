class UserModel {
  String? uid;
  String? username;
  String? email;
  int? createdAt;

  UserModel({this.uid, this.username, this.email, this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    email = json['email'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['username'] = username;
    data['email'] = email;
    data['createdAt'] = createdAt;
    return data;
  }
}