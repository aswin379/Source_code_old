import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/account_response.dart';
import 'package:http/http.dart' as http;

import '../helpers/main_helpers.dart';

class AccountRepository {
  // fetch profile

  Future<AccountResponse> fetchAccountInfo() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/dashboard";
    var accessToken = getToken;

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = profileResponseFromJson(response.body);
    return data;
  }
}
