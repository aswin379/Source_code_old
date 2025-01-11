import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/my_happy_stories/get_happy_story_middleware.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/main_helpers.dart';
import '../../core.dart';
import 'my_happy_story_action.dart';

ThunkAction<AppState> happystorystoreMiddleware({
  context,
  dynamic title,
  dynamic details,
  dynamic partner_name,
  dynamic photos,
  dynamic video_provider,
  dynamic video_link,
}) {
  return (Store<AppState> store) async {
    store.dispatch(HappyLoader());

    var baseUrl = "${AppConfig.BASE_URL}/member/happy-story";
    var accessToken = getToken;

    final uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);
    request.fields["title"] = title;
    request.fields["details"] = details;
    request.fields["partner_name"] = partner_name;

    if (photos != null) {
      var pic = await http.MultipartFile.fromPath("photos", photos.path);
      request.files.add(pic);
    }
    request.fields["video_provider"] = video_provider;
    request.fields["video_link"] = video_link;

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    });

    var response = await request.send();
    store.dispatch(HappyLoader());

    store.dispatch(happyStoryCheckMiddleware());

    if (response.statusCode == 200) {
      store.dispatch(ShowMessageAction(
          msg: "Information Successfully saved!", color: MyTheme.success));
    } else {
      var message = await response.stream.bytesToString();
      var errors = jsonDecode(message)['message'];
      store.dispatch(ShowMessageAction(msg: errors, color: MyTheme.failure));
    }
  };
}
