class Banners {
  String? mainText = '';
  String? image = '';

  Banners({this.image, this.mainText});
  Banners.fromMap(Map map)
      : mainText = map['mainText'] ?? '',
        image = map['image'] ?? '';
}
