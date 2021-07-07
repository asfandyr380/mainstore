class SummeryModel {
  double? subtotal = 0;
  double? shipping = 0;
  double? total = 0;

  SummeryModel.mapData(
    double? subtotal,
    double? shipping,
    double? total,
  )   : this.subtotal = subtotal,
        this.shipping = shipping,
        this.total = total;
}
