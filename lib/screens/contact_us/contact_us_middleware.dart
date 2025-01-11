import 'package:flutter/material.dart';

import '../../const/my_theme.dart';
import '../../repository/contact_us_repository.dart';
import '../core.dart';

ThunkAction<AppState> contactUsMiddleware({postBody, context}) {
  return (Store<AppState> store) async {
    store.dispatch(SaveChanges.contactUs);

    try {
      var data = await ContactUsRepository().sendHelp(postBody: postBody);

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
      if (data.result) {
        store.state.contactUsState!.nameController!.clear();
        store.state.contactUsState!.emailController!.clear();
        store.state.contactUsState!.subjectController!.clear();
        store.state.contactUsState!.descriptionController!.clear();
        Navigator.pop(context);
      }
    } catch (e) {
      // print("error ${e.toString()}");
      debugPrint(e.toString());
      return;
    }
    store.dispatch(SaveChanges.contactUs);
  };
}
