import 'package:flutter/material.dart';

class PublicProfileStoreAction {
  var data;

  @override
  String toString() {
    return 'PublicProfileStoreAction{data: $data}';
  }

  PublicProfileStoreAction({this.data});
}

class PublicProfileFailureAction {
  String? error;

  PublicProfileFailureAction({this.error});

  @override
  String toString() {
    return 'PublicProfileFailureAction{error: $error}';
  }
}

class ImageFullViewAction {
  BuildContext? contextPayload;
  var indexPayload;

  ImageFullViewAction({this.contextPayload, this.indexPayload});

  @override
  String toString() {
    return 'ImageFullViewAction{contextPayload: $contextPayload, indexPayload: $indexPayload}';
  }
}
