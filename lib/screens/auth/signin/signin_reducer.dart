import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_action.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_state.dart';
import 'package:flutter/material.dart';

import '../../core.dart';
import 'signin_middleware.dart';

SignInState? sign_in_reducer(SignInState? state, dynamic action) {
  if (action is SignInAction) {
    return loader(state, action);
  }
  if (action is IsPhoneOrEmailChangeAction) {
    state!.isPhone = !state.isPhone!;
    return state;
  }
  if (action is IsPhoneOrEmailChangeCustomPopAction) {
    action.setState!(() {
      state!.isPhone = !state.isPhone!;
    });

    print(
        'get setting values: ${store.state.addonState!.data?.otpSystem ?? false}');
    print(state!.isPhone);
    return state;
  }
  if (action is SetPhoneNumberAction) {
    state!.phoneNumber = action.payload;
    return state;
  }
  if (action is IsObscureAction) {
    state!.isObscure = !state.isObscure!;
    return state;
  }
  if (action is LoginRequest) {
    FocusManager.instance.primaryFocus?.unfocus();

    print(state!.phoneNumber);
    if (!requiredFieldVerification(state!)) {
      return state;
    }
    bool isOtp = store.state.addonState!.data?.otpSystem ?? false;

    var emailOrPhone = isOtp
        ? state.isPhone!
            ? state.phoneNumber
            : state.emailController!.text
        : state.emailController!.text;

    state.passwordErrorText = '';
    state.emailErrorText = '';
    store.dispatch(
      signInMiddleware(
        context: action.payloadContext,
        email: emailOrPhone,
        password: state.passwordController!.text,
      ),
    );
    return state;
  }

  if (action is ClearAction) {
    state!.passwordErrorText = '';
    state.emailErrorText = '';
  }

  return state;
}

bool requiredFieldVerification(SignInState state) {
  bool isOtp = store.state.addonState!.data?.otpSystem ?? false;

  if (isOtp) {
    if (state.isPhone! == "") {
      state.emailErrorText = "Please enter mobile number";
      return false;
    }
  } else if (state!.emailController!.text.isEmpty) {
    state.emailErrorText = "Please enter email address";
    return false;
  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(state.emailController!.text)) {
    state.emailErrorText = "Please enter a valid email address";
    return false;
  } else if (state.passwordController!.text.isEmpty) {
    state.passwordErrorText = "Please enter password";
    return false;
  } else if (state.passwordController!.text.length <= 7) {
    state.passwordErrorText = "Password should be 8 Characters long";
    return false;
  }

  return true;
}

class IsPhoneOrEmailChangeAction {}

class IsPhoneOrEmailChangeCustomPopAction {
  bool? valueChang;
  StateSetter? setState;

  IsPhoneOrEmailChangeCustomPopAction({this.setState, this.valueChang});

  @override
  String toString() {
    return 'IsPhoneOrEmailChangeCustomPopAction{setState: $setState}';
  }
}

class LoginRequest {
  BuildContext? payloadContext;

  LoginRequest({this.payloadContext});

  @override
  String toString() {
    return 'LoginRequest{payloadContext: $payloadContext}';
  }
}

class ClearAction {}

loader(SignInState? state, SignInAction action) {
  if (action.from == "custom") {
    state!.isCustomLogin = !state.isCustomLogin!;
  } else {
    state!.isLogin = !state.isLogin!;
  }
  return state;
}
