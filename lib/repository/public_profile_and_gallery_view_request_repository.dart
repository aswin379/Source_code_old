import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../helpers/main_helpers.dart';
import '../models_response/others/common_response.dart';

class ProfileAndGalleryViewRequestRepository {
  /// below one for public profile send---- accept----and reject
  /// there will be for gallery after the section

  // public profile view request send
  Future<CommonResponse> sendProfilePictureViewRequest(
      {required int id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/profile-picture-view-request";
    var accessToken = getToken;

    var postBody = jsonEncode({"id": id});

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
  // public profile view request accept

  Future<CommonResponse> profilePictureViewRequestAccept({id}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/profile-picture-view-request/accept";
    var accessToken = getToken;

    var postBody = jsonEncode({"profile_pic_view_request_id": id});
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
  // public profile view request reject

  Future<CommonResponse> profilePictureViewRequestReject({id}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/profile-picture-view-request/reject";
    var accessToken = getToken;

    var postBody = jsonEncode({"profile_pic_view_request_id": id});
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

  /// gallery picture view
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  Future<CommonResponse> postGalleryPictureViewRequest(
      {required int id}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/gallery-image-view-request";
    var accessToken = getToken;

    var postBody = jsonEncode({"id": id});

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

  Future<CommonResponse> postGalleryPictureAcceptReject(
      {isAcceptReject, id}) async {
    var baseUrl =
        "${AppConfig.BASE_URL}/member/gallery-image-view-request/$isAcceptReject";
    var accessToken = getToken;

    var postBody = jsonEncode({"gallery_image_view_request_id": id});

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
