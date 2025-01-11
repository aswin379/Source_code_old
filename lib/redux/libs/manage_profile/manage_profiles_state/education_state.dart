import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:flutter/material.dart';

class EducationState {
  bool? isLoading;
  bool? saveChanges;
  bool? update_changes;
  int? index;
  int? delIndex;
  bool? isDelete;

  var list = <EducationViewModel>[];

  // controllers
  TextEditingController? degreeController = TextEditingController();
  TextEditingController? institutionController = TextEditingController();
  TextEditingController? startController = TextEditingController();
  TextEditingController? endController = TextEditingController();

  EducationState({
    this.delIndex,
    this.isDelete,
    this.index,
    this.degreeController,
    this.institutionController,
    this.startController,
    this.endController,
    this.isLoading,
    this.saveChanges,
    this.update_changes,
  });

  EducationState.initialState()
      : update_changes = false,
        degreeController = TextEditingController(text: ''),
        institutionController = TextEditingController(text: ''),
        startController = TextEditingController(text: ''),
        endController = TextEditingController(text: ''),
        isLoading = false,
        isDelete = false,
        saveChanges = false;
}
