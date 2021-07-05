class ReviewModel {
  String? message = '';
  String? user = '';
  int? rating = 0;

  ReviewModel.fromJson(Map map)
      : message = map['message'] ?? '',
        user = map['username'] ?? '',
        rating = map['rating'] ?? 0;
}
