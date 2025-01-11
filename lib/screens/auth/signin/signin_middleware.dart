import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/auth_helper.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_action.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../helpers/shared_pref.dart';
import '../../../repository/app_info_repository.dart';
import '../../app_navigation.dart';
import '../verify/verify_action.dart';

ThunkAction<AppState> signInMiddleware({email, password, from, context}) {
  return (Store<AppState> store) async {
    store.dispatch(SignInAction(from: from));
    var data =
        (await AuthRepository().signIn(email: email, password: password))!;

    if (data.result == true) {
      /// setting auth user data
      /// into shared pref
      setUserData(data);
      store.dispatch(
          ShowMessageAction(msg: data.message, color: MyTheme.success));
      store.dispatch(getUserIsApproveAction());

      // route redirect to main
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AppNavigation()),
          (route) => false);

      // clear login controllers
      store.state.signInState!.emailController!.clear();
      store.state.signInState!.passwordController!.clear();

      // firebase store fcm token fire
      final FirebaseMessaging _fcm = FirebaseMessaging.instance;

      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      String? fCMToken = await _fcm.getToken();

      if (fCMToken != null) {
        if (SharedPref().isLoggedIn) {
          // update device token
          var deviceTokenUpdateResponse = await AppInfoRepository()
              .getDeviceTokenUpdateResponse(deviceToken: fCMToken);
        }
      }

      // firebase store fcm token end
    } else {
      store.dispatch(
          ShowMessageAction(msg: data.message, color: MyTheme.failure));
    }

    store.dispatch(SignInAction(from: from));
  };
}
