import 'dart:convert';
import 'dart:io';

import 'package:active_matrimonial_flutter_app/screens/auth/verify/verify_action.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/verify/verify_state.dart';
import 'package:flutter/material.dart';

UserVerifyState? userVerifyReducer(UserVerifyState state, dynamic action) {
  if (action is VerifyFormStoreAction) {
    return storeForm(state, action);
  }
  if (action is SetSelectValueAction) {
    state.formList![action.index!].data = action.payload;
    return state;
  }
  if (action is SetMultipleSelectValueAction) {
    state.formList![action.index!].data.add(action.payload);
    return state;
  }
  if (action is SetMultipleSelectRemoveAction) {
    state.formList![action.index!].data.removeAt(action.payload);
    return state;
  }
  if (action is SetFileAction) {
    state.formList![action.index!].data = action.payload;
    return state;
  }
  if (action is IsApprovedAction) {
    state.isApprove = action.payload!.isApproved! == 1 ? true : false;
    state.verificationInfo = action.payload!.verificationInfo;
    return state;
  }
  return state;
}

storeForm(UserVerifyState state, VerifyFormStoreAction action) {
  // print('store form of the user verification form');
  state.formList = [];

  for (int i = 0; i < action.payload!.length; i++) {
    if (action.payload![i].type == "text") {
      TextEditingController value = TextEditingController();
      state.formList!.add(
        VerificationModel<TextEditingController?>(
          key: "element_$i",
          type: action.payload![i].type,
          title: action.payload![i].label,
          data: value,
        ),
      );
    } else if (action.payload![i].type == "file") {
      File? value;
      state.formList!.add(VerificationModel<File?>(
          key: "element_$i",
          type: action.payload![i].type,
          title: action.payload![i].label,
          data: value));
    } else if (action.payload![i].type == "select") {
      String? value;
      var options = jsonDecode(action.payload![i].options!);

      state.formList!.add(VerificationModel<String?>(
          key: "element_$i",
          type: action.payload![i].type,
          title: action.payload![i].label,
          data: value,
          options: options));
    } else if (action.payload![i].type == "multi_select") {
      List<String> value = [];
      var options = jsonDecode(action.payload![i].options!);
      state.formList!.add(VerificationModel<List<String>?>(
          key: "element_$i",
          type: action.payload![i].type,
          title: action.payload![i].label,
          data: value,
          options: options));
    } else if (action.payload![i].type == "radio") {
      var options = jsonDecode(action.payload![i].options!);

      String? value = options.first;
      state.formList!.add(VerificationModel<String?>(
          key: "element_$i",
          type: action.payload![i].type,
          title: action.payload![i].label,
          data: value,
          options: options));
    }
  }

  state.isFetching = false;

  return state;
}
