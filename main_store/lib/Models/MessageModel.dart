class MessageModel {
  String? name = '';
  String? email = '';
  String? phone = '';
  String? message = '';

  MessageModel({this.email, this.message, this.name, this.phone});

  MessageModel.fromJson(Map map)
      : name = map['name'],
        email = map['email'],
        phone = map['phone'],
        message = map['message'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'message': message,
      };
}
