import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../helpers/main_helpers.dart';
import '../models_response/matched_profile_response.dart';

class MatchedProfileRepository {
  Future<MatchedProfileResponse> fetchMatchedProfiles() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/matched-profile";
    var accessToken = getToken;

    var response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var data = matchedProfileResponseFromJson(response.body);

    return data;
  }
}
