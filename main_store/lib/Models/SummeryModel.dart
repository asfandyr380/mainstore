class SummeryModel {
  double? subtotal = 0;
  double? shipping = 0;
  double? total = 0;
  List<int> ids = [];

  SummeryModel.mapData(
      double? subtotal, double? shipping, double? total, List<int> ids)
      : this.subtotal = subtotal,
        this.shipping = shipping,
        this.total = total,
        this.ids = ids;
}
