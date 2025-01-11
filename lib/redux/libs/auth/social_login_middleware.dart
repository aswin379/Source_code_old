import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/app_navigation.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_action.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup_verify.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';

import '../../../helpers/auth_helper.dart';

ThunkAction<AppState> socialLoginMiddleware({
  required BuildContext context,
  email,
  name,
  provider,
  secret_token = "",
  social_provider,
  access_token = "",
}) {
  return (Store<AppState> store) async {
    store.dispatch(SignInAction());

    try {
      var data = await AuthRepository().socialLogin(
        email: email,
        name: name,
        provider: provider,
        secret_token: secret_token,
        social_provider: social_provider,
        access_token: access_token,
      );

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));

      if (data.message == "Please verify your account") {
        NavigatorPush.push(context, SignupVerify());
      } else if (data.message == "Please wait for admin approval") {
        // NavigatorPush.push(context, Login());
        // Navigator.pop(context);
      }

      if (data.result == true) {
        /// setting auth user data
        /// into shared pref
        setUserData(data);
        NavigatorPush.push_remove_untill(page: AppNavigation());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    store.dispatch(SignInAction());
  };
}
