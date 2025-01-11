
import 'package:flutter/material.dart';

import '../const/my_theme.dart';
import '../screens/core.dart';

Future<void> checkUserVerificationAndNavigate(
    BuildContext context, dynamic page) async {

  if (store.state.userVerifyState?.isApprove != true) {
    OneContext().pop(); // Pop the current route
    store.dispatch(
      ShowMessageAction(
        msg: "Please verify your account",
        color: MyTheme.failure,
      ),
    );
  } else {
    // Navigate to the page if user is verified
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}