class UserAuthModel {
  String? uId;
  String? name;
  String? email;

  UserAuthModel({this.uId, this.name, this.email});

  UserAuthModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
