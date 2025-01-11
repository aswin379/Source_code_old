import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/education_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_delete_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class EducationCard extends StatelessWidget {
  final String? degreeHint;
  final TextEditingController? degreeController;
  final String? instituteHint;
  final TextEditingController? instituteController;
  final String? startHint;
  final TextEditingController? startController;
  final String? endHint;
  final TextEditingController? endController;

  final bool? status;
  final int? listId;

  int? delIndex;
  final int? index;

  final int? responseId;

  final bool? isDelete;
  late final int? educationStateIndex;
  late final GlobalKey<FormState>? ky;

  final String? degreeText;
  final String? instituteText;
  final String? startText;
  final String? endText;
  final bool? updateChanges;

  EducationCard(
      {Key? key,
      this.degreeHint,
      this.degreeController,
      this.instituteHint,
      this.instituteController,
      this.startHint,
      this.startController,
      this.endHint,
      this.endController,
      this.status,
      this.listId,
      this.index,
      this.responseId,
      this.isDelete,
      this.educationStateIndex,
      this.ky,
      this.degreeText,
      this.instituteText,
      this.startText,
      this.endText,
      this.updateChanges,
      this.delIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [CommonWidget.box_shadow()]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.manage_profile_degree,
                      style: Styles.bold_arsenic_12,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputStyle.inputDecoration_text_field(
                            hint: degreeHint),
                        controller: degreeController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.manage_profile_institution,
                      style: Styles.bold_arsenic_12,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputStyle.inputDecoration_text_field(
                            hint: instituteHint),
                        controller: instituteController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.manage_profile_start,
                      style: Styles.bold_arsenic_12,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputStyle.inputDecoration_text_field(
                            hint: startHint),
                        controller: startController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.manage_profile_end,
                      style: Styles.bold_arsenic_12,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputStyle.inputDecoration_text_field(
                            hint: endHint),
                        controller: endController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Status',
                      style: Styles.bold_arsenic_12,
                    ),
                    Switch(
                      value: status!,
                      onChanged: (value) {
                        store.dispatch(
                            EducationStatusAction(status: value, id: listId));
                      },
                      activeColor: Colors.green,
                      activeTrackColor: MyTheme.zircon,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: MyTheme.zircon,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    delIndex = index;

                    store.dispatch(eudcationDeleteMiddleware(id: responseId));
                  },
                  child: Container(
                    height: 45,
                    width: DeviceInfo(context).width,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.app_accent_color),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    child: Center(
                      child: isDelete! && delIndex == index
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyTheme.storm_grey,
                              ),
                            )
                          : Text(
                              "Delete",
                              style: Styles.bold_arsenic_14,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    educationStateIndex = index;
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (!ky!.currentState!.validate()) {
                    } else {
                      store.dispatch(eudcationUpdateMiddleware(
                          degree: degreeText,
                          institution: instituteText,
                          start: startText,
                          end: endText,
                          id: responseId));
                    }
                  },
                  child: Container(
                    height: 45,
                    width: DeviceInfo(context).width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 1),
                        colors: [
                          MyTheme.gradient_color_1,
                          MyTheme.gradient_color_2,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    child: Center(
                      child: updateChanges! && educationStateIndex == index
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyTheme.storm_grey,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!
                                  .save_change_btn_text,
                              style: Styles.bold_white_14,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
