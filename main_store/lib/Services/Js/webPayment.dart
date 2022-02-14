@JS()
library stripe;

import 'package:js/js.dart';
import 'package:main_store/Config/consts.dart';

void redirectToCheckout(String sessionId) {
  final stripe = Stripe(apiKey);
  stripe.redirectToCheckout(
    CheckoutOptions(sessionId: sessionId),
  );
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external String get sessionId;
  external factory CheckoutOptions({
    String sessionId,
  });
}
