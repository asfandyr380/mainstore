class Swipebanner {
  String? subText = '';
  String? mainText = '';
  String? image = '';

  Swipebanner({this.image, this.mainText, this.subText});

  Swipebanner.fromMap(Map map)
      : mainText = map['mainText'] ?? '',
        subText = map['subText'] ?? '',
        image = map['image'] ?? '';
}
