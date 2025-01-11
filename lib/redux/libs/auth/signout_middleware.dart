import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/get_context.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/auth_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../helpers/auth_helper.dart';
import '../helpers/show_message_state.dart';

ThunkAction<AppState> signOutMiddleware(
  ctx,
) {
  return (Store<AppState> store) async {
    try {
      var data = await AuthRepository().logout();

      if (data.result) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));

        /// cleaning auth data after logout
        clearUserData();

        NavigatorPush.push_remove_untill(page: const AppNavigation());
        SystemHelper.isBlockScreenShown = false;
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  };
}
