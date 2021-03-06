class Swipebanner {
  int? id = 0;
  String? subText = '';
  String? mainText = '';
  String? image = '';
  String? cate = '';

  Swipebanner({this.id, this.cate, this.image, this.mainText, this.subText});

  Swipebanner.fromMap(Map map)
      : id = map['id'] ?? 0,
        mainText = map['mainText'] ?? '',
        subText = map['subText'] ?? '',
        image = map['image'] ?? '',
        cate = map['cate'];
}
