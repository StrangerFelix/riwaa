class UserModel {
  String? name;
  String? uId;
  String? email;

  UserModel({this.name, this.uId, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['uId'] = uId;
    data['email'] = email;
    return data;
  }
}
