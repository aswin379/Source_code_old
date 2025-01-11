import 'package:flutter/material.dart';

class ForgetPassword {}

class SendCodeAction {
  BuildContext? payloadContext;

  SendCodeAction({this.payloadContext});

  @override
  String toString() {
    return 'SendCodeAction{payloadContext: $payloadContext}';
  }
}

class FpLoader {}

class ForgetPasswordEmailOrPhoneAction {}

class SetForgetPasswordPhoneNumberAction {
  String? payload;

  SetForgetPasswordPhoneNumberAction({this.payload});

  @override
  String toString() {
    return 'SetForgetPasswordPhoneNumberAction{payload: $payload}';
  }
}
