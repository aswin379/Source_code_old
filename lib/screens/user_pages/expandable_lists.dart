import 'package:active_matrimonial_flutter_app/components/public_profile_list.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_astronomic_Info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_basic_information.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_career_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_education_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_family_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_hobbies_n_interest.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_introduction.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_language.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_life_style.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_permanent_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_personal_n_attitude.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_physical_attri.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_present_address.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_residency_info.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_spiritual_n_social.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_usercontact_details.dart';
import 'package:flutter/material.dart';

class ExpandableLists extends StatelessWidget {
  final int userId;

  const ExpandableLists({required this.userId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            right: Const.kPaddingHorizontal,
            left: Const.kPaddingHorizontal,
            bottom: 10),
        child: ListView(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyProfileListData(
              title2: "About",
              subtitle2:
                  "On Behalf ${store.state.publicProfileState!.basic?.onbehalf?.name}",
              icon2: 'assets/icon/icon_left_qoute.png',
              pp2: const PP_Information(),
            ).getExpandableWidget(context, index: 0),
            Const.height20,
            MyProfileListData(
              title2: "Basic Information",
              icon2: 'assets/icon/icon_basicInfo.png',
              pp2: const PP_BasicInformation(),
            ).getExpandableWidget(context),
            Const.height20,
            MyProfileListData(
              title2: "Contact Details",
              icon2: 'assets/icon/icon_contactDetails.png',
              pp2: PP_UserContactDetails(userid: userId),
            ).getExpandableWidget(context),
            Const.height20,
            if (settingIsActive("member_present_address_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Present Address",
                    icon2: 'assets/icon/icon_presentAddress.png',
                    pp2: const PP_PresentAddress(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_education_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Education Details",
                    icon2: 'assets/icon/icon_educationCareer.png',
                    pp2: const PP_EducationInfo(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_career_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Career Details",
                    icon2: 'assets/icon/icon_educationCareer.png',
                    pp2: const PP_CareerInfo(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_physical_attributes_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Physical Attributes",
                    icon2: 'assets/icon/icon_physicalAttri.png',
                    pp2: const PP_PhysicalAttributes(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_language_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Language",
                    icon2: 'assets/icon/icon_language.png',
                    pp2: const PP_Language(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_hobbies_and_interests_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Hobbies & Interest",
                    icon2: 'assets/icon/icon_hobbiesInterest.png',
                    pp2: const PP_HobbiesInterest(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive(
                "member_personal_attitude_and_behavior_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Personal Attitude & Behavior",
                    icon2: 'assets/icon/icon_personalAttitude.png',
                    pp2: const PP_PersonalAttitude(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_residency_information_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Residency Information",
                    icon2: 'assets/icon/icon_residency.png',
                    pp2: const PP_ResidencyInfo(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive(
                "member_spiritual_and_social_background_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Spiritual & Social Background",
                    icon2: 'assets/icon/icon_spiritualSocial.png',
                    pp2: const PP_SpiritualSocial(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_life_style_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Life Style",
                    icon2: 'assets/icon/icon_lifeStyle.png',
                    pp2: const PP_LifeStyle(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_astronomic_information_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Astronomic Information",
                    icon2: 'assets/icon/icon_astronomy.png',
                    pp2: const PP_AstronomicInfo(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_permanent_address_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Permanent Address",
                    icon2: 'assets/icon/icon_permanentAddress.png',
                    pp2: const PP_PermanentAddress(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              ),
            if (settingIsActive("member_family_information_section", "on"))
              Column(
                children: [
                  MyProfileListData(
                    title2: "Family Information",
                    icon2: 'assets/icon/icon_family.png',
                    pp2: const PP_FamilyInfo(),
                  ).getExpandableWidget(context),
                  Const.height20,
                ],
              )
          ],
        ),
      ),
    );
  }
}
