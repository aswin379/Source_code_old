import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/models_response/others/common_response.dart';
import 'package:active_matrimonial_flutter_app/screens/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/public_profile_middleware.dart';
import 'package:http/http.dart' as http;

import '../helpers/shared_pref.dart';

class ContactView {
  Future<CommonResponse> postContactView({id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/view-contact-store";
    var accessToken = SharedPref().accessToken;
    var postBody = jsonEncode({
      "id": id,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var responseBody = commonResponseFromJson(response.body);

    return responseBody;
  }
}

ThunkAction<AppState> postContactView({id}) {
  return (Store<AppState> store) async {
    try {
      CommonResponse response = await ContactView().postContactView(id: id);

      if (response.result == true) {
        store.dispatch(publicProfileMiddleware(userId: id));
        store.dispatch(accountMiddleware());

        store.dispatch(
            ShowMessageAction(msg: response.message, color: MyTheme.success));
      } else {
        store.dispatch(
            ShowMessageAction(msg: response.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e.toString());
    }
  };
}
