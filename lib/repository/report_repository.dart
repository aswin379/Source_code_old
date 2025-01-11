import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/models_response/others/common_response.dart';
import 'package:http/http.dart' as http;

import '../helpers/main_helpers.dart';

class ReportRepository {
  Future<CommonResponse> report({int? userId, dynamic reason}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/report-member";
    var accessToken = getToken;

    var postBody = jsonEncode({"user_id": userId, "reason": reason});
    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);

    return data;
  }
}
