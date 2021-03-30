import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pay_platform_interface/core/payment_item.dart';

import 'pay_platform_interface.dart';

class PayMethodChannel extends PayPlatform {
  final MethodChannel _channel =
      const MethodChannel('plugins.flutter.io/pay_channel');

  @override
  Future<bool> userCanPay(Map<String, dynamic> paymentProfile) async =>
      await _channel.invokeMethod('userCanPay', jsonEncode(paymentProfile));

  @override
  Future<Map<String, dynamic>> showPaymentSelector(
    Map<String, dynamic> paymentProfile,
    List<PaymentItem> paymentItems,
  ) async {
    final paymentResult = await _channel.invokeMethod('showPaymentSelector', {
      'payment_profile': jsonEncode(paymentProfile),
      'payment_items': paymentItems.map((item) => item.toMap()).toList(),
    });

    return jsonDecode(paymentResult);
  }
}
