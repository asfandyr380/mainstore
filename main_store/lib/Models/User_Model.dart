class UserModel {
  int? id = 0;
  String? username = '';
  String? email = '';
  String? mobile = '';
  String? password = '';

  UserModel({this.email, this.id, this.mobile, this.password, this.username});

  UserModel.fromJson(Map map)
      : id = map['id'] ?? 0,
        username = map['username'] ?? '',
        email = map['email'] ?? '',
        mobile = map['mobile'] ?? '';

  Map<String, dynamic> toJson() =>
      {'email': email ?? '', 'password': password ?? ''};
}
