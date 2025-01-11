import 'dart:convert';

import 'package:active_matrimonial_flutter_app/models_response/others/token_update_response.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../helpers/shared_pref.dart';
import '../models_response/others/addon_check_response.dart';
import '../models_response/others/app_info_response.dart';
import '../models_response/others/static_page_response.dart';

class AppInfoRepository {
  // fetch app info list

  Future<AppInfoResponse> fetchAppInfo() async {
    var baseUrl = "${AppConfig.BASE_URL}/app-info";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = appInfoResponseFromJson(response.body);
    return data;
  }

  Future<AddonCheckResponse> fetchAddonCheck() async {
    var baseUrl = "${AppConfig.BASE_URL}/addon-check";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = addonCheckResponseFromJson(response.body);
    return data;
  }

  Future<StaticPageResponse> fetchStaticPage() async {
    var baseUrl = "${AppConfig.BASE_URL}/static-page";

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });

    var data = staticPageResponseFromJson(response.body);
    return data;
  }

  Future<TokenUpdateResponse> getDeviceTokenUpdateResponse(
      {deviceToken}) async {
    var baseUrl = "${AppConfig.BASE_URL}/update-device-token";
    var accessToken = SharedPref().accessToken;

    var postBody = jsonEncode({
      "device_token": deviceToken,
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: postBody);

    var data = tokenUpdateResponseFromJson(response.body);
    return data;
  }
}
