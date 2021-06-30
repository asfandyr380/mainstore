class Banners {
  int? id = 0;
  String? mainText = '';
  String? image = '';

  Banners({this.image, this.mainText, this.id});

  Banners.fromMap(Map map)
      : id = map['bannerid'] ?? 0,
        image = map['image'] ?? '',
        mainText = map['mainText'];
}
