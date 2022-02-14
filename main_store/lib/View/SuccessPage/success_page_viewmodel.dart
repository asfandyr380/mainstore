import 'package:flutter/cupertino.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Api/Cart/cart_services.dart';

class SuccessPageViewModel extends ChangeNotifier {
  CartService _cartService = locator<CartService>();
  init(String? checkoutId, var userData) async {
    if (checkoutId != null && userData != null) {
      if (!await _cartService.checkOrder(checkoutId)) {
        createOrder(
          checkoutId,
          userData['username'],
          userData['address'],
          userData['postal'],
          userData['ids'],
        );
        await _cartService.updateCheckoutStatus(checkoutId);
      }
    }
  }

  updateCart(List<String> ids, String orderId) async {
    for (var id in ids) {
      await _cartService.updateCartStatus(id, orderId);
    }
  }

  createOrder(String id, String username, String address, String postal,
      String ids) async {
    Map<String, dynamic> body = {
      "userAddress": address,
      "checkout_Id": id,
      "date": DateTime.now().toString(),
      "postalCode": postal,
      "order_status": "1",
      "username": username,
      "seen": "0"
    };
    var res = await _cartService.createOrder(body);
    if (res is int) {
      updateCart(ids.split(','), res.toString());
    } else {}
  }
}
