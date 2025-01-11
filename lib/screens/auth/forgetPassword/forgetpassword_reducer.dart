import 'package:active_matrimonial_flutter_app/helpers/shared_pref.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/forgetPassword/forgetpassword_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../main.dart';
import 'forgetpassword_action.dart';
import 'forgetpassword_middleware.dart';

ForgetPasswordState? forgetpassword_reducer(
    ForgetPasswordState? state, dynamic action) {
  if (action is FpLoader) {
    return loader(state!, action);
  }
  if (action is ForgetPasswordEmailOrPhoneAction) {
    state!.valueChanger = !state.valueChanger!;
    return state;
  }
  if (action is SetForgetPasswordPhoneNumberAction) {
    state!.phoneNumber = action.payload;
    return state;
  }
  if (action is SendCodeAction) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (state!.formKey.currentState!.validate()) {
      var send_by = state.valueChanger! ? "phone" : "email";
      var email = state.valueChanger!
          ? state.phoneNumber
          : state.forgetpasswordController!.text;

      store.dispatch(forgetPasswordMiddleware(
          send_by: send_by, email: email, context: action.payloadContext));
      // print(send_by);
      // print(email);

      SharedPref().resetSendBy = send_by;
      SharedPref().resetEmail = email;
    }

    state.forgetpasswordController!.clear();
  }
  return state;
}

loader(ForgetPasswordState state, FpLoader action) {
  state.fp_loader = !state.fp_loader!;
  return state;
}
