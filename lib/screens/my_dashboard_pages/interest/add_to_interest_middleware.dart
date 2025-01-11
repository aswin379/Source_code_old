import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/shortlist/shortlist_response.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../helpers/main_helpers.dart';

ThunkAction<AppState> add_to_interest_middleware() {
  return (Store<AppState> store) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/my-shortlists";
    var accessToken = getToken!;

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      });

      var data = shortlistResponseFromJson(response.body);
      // print(data.result);
      store.dispatch(ShortlistResponse(
        result: data.result,
        data: data.data,
      ));
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}
