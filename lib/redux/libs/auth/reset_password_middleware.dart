import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin.dart';
import 'package:flutter/material.dart';

import '../../../screens/core.dart';

ThunkAction<AppState> resetPasswordMiddleware({
  required String sendBy,
  required String emailOrPhone,
  required password,
  required confirm_password,
  required String opt,
  required BuildContext context,
}) {
  return (Store<AppState> store) async {
    store.dispatch(RpLoader());

    try {
      var data = await AuthRepository().resetPassword(
        sendBy: sendBy,
        emailOrPhone: emailOrPhone,
        password: password,
        confirm_password: confirm_password,
        otp: opt,
      );

      if (data.result) {
        store.dispatch(
          ShowMessageAction(
            msg: data.message,
            color: MyTheme.success,
          ),
        );

        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Login(),
          ),
        );
      } else {
        store.dispatch(
          ShowMessageAction(
            msg: data.message,
            color: MyTheme.failure,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
    store.dispatch(RpLoader());
  };
}
