import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/education_card.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_create_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_get_middlewares.dart';

class EducationInfo extends StatefulWidget {
  const EducationInfo({Key? key}) : super(key: key);

  @override
  State<EducationInfo> createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_Education_info,
        ).build(context),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Const.kPaddingHorizontal,
                  right: Const.kPaddingHorizontal,
                ),
                child: buildTitle(context, state),
              ),
              Form(key: formKey, child: build_body(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget build_body(BuildContext context, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => store.dispatch(educationGetMiddleware()),
        child: ListView.separated(
          padding: EdgeInsets.only(
              left: Const.kPaddingHorizontal,
              right: Const.kPaddingHorizontal,
              bottom: 10),
          shrinkWrap: true,
          itemCount:
              state.manageProfileCombineState!.educationState!.list.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return EducationCard(
              degreeHint: state.manageProfileCombineState!.educationState!
                  .list[index].degree_hint,
              degreeController: state.manageProfileCombineState!.educationState!
                  .list[index].degree_controller,
              instituteHint: state.manageProfileCombineState!.educationState!
                  .list[index].institute_hint,
              instituteController: state.manageProfileCombineState!
                  .educationState!.list[index].institute_controller,
              startHint: state.manageProfileCombineState!.educationState!
                  .list[index].start_hint,
              startController: state.manageProfileCombineState!.educationState!
                  .list[index].start_controller,
              endHint: state.manageProfileCombineState!.educationState!
                  .list[index].end_hint,
              endController: state.manageProfileCombineState!.educationState!
                  .list[index].end_controller,
              status: state.manageProfileCombineState!.educationState!
                  .list[index].present,
              listId: state
                  .manageProfileCombineState!.educationState!.list[index].id,
              delIndex:
                  state.manageProfileCombineState!.educationState!.delIndex,
              index: index,
              responseId: state
                  .manageProfileCombineState!.educationState!.list[index].id,
              isDelete:
                  state.manageProfileCombineState!.educationState!.isDelete!,
              educationStateIndex:
                  state.manageProfileCombineState!.educationState!.index,
              ky: formKey,
              degreeText: state.manageProfileCombineState!.educationState!
                  .list[index].degree_controller.text,
              instituteText: state.manageProfileCombineState!.educationState!
                  .list[index].institute_controller.text,
              startText: state.manageProfileCombineState!.educationState!
                  .list[index].start_controller.text,
              endText: state.manageProfileCombineState!.educationState!
                  .list[index].end_controller.text,
              updateChanges: state
                  .manageProfileCombineState!.educationState!.update_changes!,
            );
          },
        ),
      ),
    );
  }

  buildTitle(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.public_profile_Your_Education_info,
              style: Styles.bold_app_accent_14,
            ),
            IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  OneContext().showDialog<void>(
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add New Education Info",
                              style: Styles.bold_arsenic_14,
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                color: MyTheme.storm_grey,
                                thickness: 1,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_degree,
                                hint: "Bachelor of Arts",
                                controller: state.manageProfileCombineState!
                                    .educationState!.degreeController,
                                style: Styles.bold_arsenic_12,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_institution,
                                hint: "Middlebury College",
                                controller: state.manageProfileCombineState!
                                    .educationState!.institutionController,
                                style: Styles.bold_arsenic_12,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_start,
                                hint: "Start",
                                controller: state.manageProfileCombineState!
                                    .educationState!.startController,
                                style: Styles.bold_arsenic_12,
                                keyboard_type: TextInputType.number,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_end,
                                hint: "End",
                                controller: state.manageProfileCombineState!
                                    .educationState!.endController,
                                style: Styles.bold_arsenic_12,
                                keyboard_type: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 1),
                                  colors: [
                                    MyTheme.gradient_color_1,
                                    MyTheme.gradient_color_2,
                                  ],
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                              ),
                              child: Center(
                                child: store.state.manageProfileCombineState!
                                            .educationState!.saveChanges !=
                                        false
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
                            onPressed: () {
                              Navigator.pop(context);
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!formKey.currentState!.validate()) {
                                // store.dispatch(ShowMessageAction(
                                //     msg: "Form's not validated!"));
                              } else {
                                store.dispatch(
                                  education_create_middleware(
                                    degree: state.manageProfileCombineState!
                                        .educationState!.degreeController!.text,
                                    institution: state
                                        .manageProfileCombineState!
                                        .educationState!
                                        .institutionController!
                                        .text,
                                    start: state.manageProfileCombineState!
                                        .educationState!.startController!.text,
                                    end: state.manageProfileCombineState!
                                        .educationState!.endController!.text,
                                  ),
                                );
                                state.manageProfileCombineState!.educationState!
                                    .degreeController!
                                    .clear();
                                state.manageProfileCombineState!.educationState!
                                    .institutionController!
                                    .clear();
                                state.manageProfileCombineState!.educationState!
                                    .startController!
                                    .clear();
                                state.manageProfileCombineState!.educationState!
                                    .endController!
                                    .clear();
                              }
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
