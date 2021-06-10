class AvailableProducts {
  String? productId = '';
  int? sold = 0;

  AvailableProducts({this.productId, this.sold});
  AvailableProducts.fromMap(Map map, String docId)
      : sold = map['sold'] ?? 0,
        productId = docId;
}
