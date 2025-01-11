import 'package:flutter/material.dart';

class ResetPasswordState {
  bool? passwordObscure;
  bool? confirmPasswordObscure;
  bool? rp_loader;

  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  TextEditingController? verifyController = TextEditingController();

  ResetPasswordState({
    this.passwordObscure,
    this.confirmPasswordObscure,
    this.rp_loader,
    this.passwordController,
    this.confirmPasswordController,
    this.verifyController,
  });

  ResetPasswordState.initialState()
      : passwordObscure = true,
        rp_loader = false,
        passwordController = TextEditingController(text: ''),
        confirmPasswordController = TextEditingController(text: ''),
        verifyController = TextEditingController(text: ''),
        confirmPasswordObscure = true;
}
