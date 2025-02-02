import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentService {
  static final InAppPurchase _iap = InAppPurchase.instance;
  static final Stream<List<PurchaseDetails>> purchaseStream = _iap.purchaseStream;

  static Future<void> buySubscription(String productId) async {
    final ProductDetailsResponse response = await _iap.queryProductDetails({productId});
    if (response.notFoundIDs.isEmpty && response.productDetails.isNotEmpty) {
      final ProductDetails productDetails = response.productDetails.first;
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  static Future<bool> isSubscriptionActive(String productId) async {
    final Completer<bool> completer = Completer<bool>();

    purchaseStream.listen((List<PurchaseDetails> purchases) {
      for (var purchase in purchases) {
        if (purchase.productID == productId && purchase.status == PurchaseStatus.purchased) {
          completer.complete(true);
          return;
        }
      }
      completer.complete(false);
    });

    return completer.future;
  }
}
