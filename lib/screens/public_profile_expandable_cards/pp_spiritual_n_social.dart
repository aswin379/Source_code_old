import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/common_widget.dart';

class PP_SpiritualSocial extends StatelessWidget {
  const PP_SpiritualSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => state.publicProfileState!.spiritual != null
          ? Column(
              children: [
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.public_profile_religion,
                    data:
                        "${state.publicProfileState!.spiritual.religionId ?? ''}"),
                Const.height10,
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_sub_caste,
                    data:
                        "${state.publicProfileState!.spiritual.subCasteId ?? ''}"),
                Const.height10,
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_personal_value,
                    data:
                        "${state.publicProfileState!.spiritual.personalValue ?? ''}"),
                Const.height10,
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_community_val,
                    data:
                        "${state.publicProfileState!.spiritual.communityValue ?? ''}"),
                Const.height10,
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_caste,
                    data:
                        "${state.publicProfileState!.spiritual.casteId ?? ''}"),
                Const.height10,
                buildRow(
                    context: context,
                    localization_text:
                        AppLocalizations.of(context)!.manage_profile_ethnicity,
                    data:
                        "${state.publicProfileState!.spiritual.ethnicity ?? ''}"),
                Const.height10,
                buildRow(
                    context: context,
                    localization_text: AppLocalizations.of(context)!
                        .manage_profile_family_value,
                    data:
                        "${state.publicProfileState!.spiritual.familyValueId ?? ''}"),
              ],
            )
          : CommonWidget.noData,
    );
  }

  Row buildRow(
      {BuildContext? context, required localization_text, required data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(localization_text, style: Styles.regular_gull_grey_12)),
        Expanded(child: Text(data))
      ],
    );
  }
}
