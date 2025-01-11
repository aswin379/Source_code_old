import 'package:flutter/material.dart';

class SignInState {
  bool? isLogin;
  bool? isCustomLogin;
  bool? isPhone;
  var phoneNumber;
  bool? isObscure;

  // controllers
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  String? emailErrorText;
  String? passwordErrorText;

  SignInState({
    this.isLogin,
    this.isPhone,
    this.isObscure,
    this.isCustomLogin,
    this.emailErrorText,
    this.passwordErrorText,
  });

  SignInState.initialState()
      : isPhone = true,
        emailErrorText = '',
        passwordErrorText = '',
        isObscure = true,
        isCustomLogin = false,
        emailController = TextEditingController(text: ''),
        passwordController = TextEditingController(text: ''),
        isLogin = false;
}
