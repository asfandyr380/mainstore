import 'package:main_store/Models/CartModel.dart';

class SummeryModel {
  double? subtotal = 0;
  double? shipping = 0;
  double? total = 0;
  List<int> ids = [];
  List<CartProducts>? products = [];

  SummeryModel.mapData(double? subtotal, double? shipping, double? total,
      List<int> ids, List<CartProducts>? products)
      : this.subtotal = subtotal,
        this.shipping = shipping,
        this.total = total,
        this.products = products,
        this.ids = ids;
}
