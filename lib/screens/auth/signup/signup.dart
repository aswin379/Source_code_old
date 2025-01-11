import 'dart:io';

import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_privacy_and_terms_page.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/components/social_login_widget.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup/signup_action.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../components/contact_faq_widget.dart';
import '../../../components/google_recaptcha.dart';
import '../../../redux/libs/drop_down/on_behalf_middleware.dart';
import '../../../redux/libs/staticPage/static_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;
  // check box value

  bool? isGoogle = settingIsActive('google_login_activation', '1');
  bool? isFacebook = settingIsActive('facebook_login_activation', '1');
  bool? isTwitter = settingIsActive('twitter_login_activation', "1");

  bool? isOtpSystem = store.state.addonState!.data!.otpSystem ?? false;
  bool? isReferralSystem =
      store.state.addonState!.data!.referralSystem ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) => [
          store.state.signUpState!.date !=
              DateTime(store.state.signUpState!.date!.year -
                  int.parse(
                      "${store.state.systemSettingState!.settingResponse!.data!['member_min_age'] ?? 0}")),
          store.dispatch(fetchOnbehalfMiddleware()),
          store.dispatch(addonCheckMiddleware()),
          store.dispatch(fetchStaticPageAction()),
        ],
        builder: (_, state) => SizedBox(
          height: DeviceInfo(context).height,
          child: Stack(
            children: [
              buildGradeintLogo(context),
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 250,
                      ),
                      Container(
                        width: DeviceInfo(context).width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.0),
                            topRight: Radius.circular(32.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Form(
                            // key form
                            key: state.signUpState!.signUpFormKey,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // on be half
                                GroupItemWithChild(
                                  title: AppLocalizations.of(context)!
                                      .signup_screen_onbehalf,
                                  style: Styles.bold_app_accent_12,
                                  child: SizedBox(
                                    height: 49,
                                    child: DropdownButtonFormField<dynamic>(
                                      iconSize: 0.0,
                                      decoration:
                                          InputStyle.inputDecoration_text_field(
                                              suffixIcon: const Icon(
                                                  Icons.keyboard_arrow_down)),
                                      value:
                                          state.signUpState!.on_behalves_value,
                                      items: state.signUpState!.onBehalfList!
                                          .map<DropdownMenuItem<dynamic>>((e) {
                                        return DropdownMenuItem<dynamic>(
                                          value: e.id,
                                          child: Text(
                                            e.name!,
                                            style: Styles.regular_arsenic_14,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (dynamic newValue) {
                                        store.dispatch(
                                            SignupSetOnBehalvesAction(
                                                payload: newValue));
                                      },
                                    ),
                                  ),
                                ),
                                Const.height18,

                                // first name
                                GroupItemWithChild(
                                  title: AppLocalizations.of(context)!
                                      .signup_screen_first_name,
                                  style: Styles.bold_app_accent_12,
                                  child: TextFormField(
                                    controller: store
                                        .state.signUpState?.firstNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter First Name';
                                      }
                                      return null;
                                    },
                                    decoration:
                                        InputStyle.inputDecoration_text_field(
                                      hint: "John",
                                    ),
                                  ),
                                ),
                                Const.height18,
                                // last name
                                GroupItemWithChild(
                                  title: AppLocalizations.of(context)!
                                      .signup_screen_last_name,
                                  style: Styles.bold_app_accent_12,
                                  child: TextFormField(
                                    controller: store
                                        .state.signUpState?.lastNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Last Name';
                                      }
                                      return null;
                                    },
                                    decoration:
                                        InputStyle.inputDecoration_text_field(
                                      hint: "Doe",
                                    ),
                                  ),
                                ),
                                Const.height18,

                                // gender
                                GroupItemWithChild(
                                  title: AppLocalizations.of(context)!
                                      .signup_screen_gender,
                                  style: Styles.bold_app_accent_12,
                                  child: SizedBox(
                                    height: 49,
                                    child: DropdownButtonFormField(
                                        validator: (dynamic val) {
                                          if (val == null || val.isEmpty) {
                                            return "Required field";
                                          }
                                          return null;
                                        },
                                        iconSize: 0.0,
                                        decoration: InputStyle
                                            .inputDecoration_text_field(
                                                suffixIcon: const Icon(
                                                    Icons.keyboard_arrow_down)),
                                        value: state.signUpState!.currentGender,
                                        items: state.signUpState!.genderItems!
                                            .map<DropdownMenuItem<dynamic>>(
                                                (e) {
                                          return DropdownMenuItem<dynamic>(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: Styles.regular_arsenic_14,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (dynamic newValue) {
                                          store.dispatch(SignupSetGenderAction(
                                              payload: newValue));
                                        }),
                                  ),
                                ),
                                Const.height18,

                                // data of birth
                                GroupItemWithChild(
                                  title: AppLocalizations.of(context)!
                                      .signup_screen_dob,
                                  style: Styles.bold_app_accent_12,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: MyTheme.solitude,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () async {
                                      DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: state.systemSettingState!
                                                .isMinimumAge!
                                            ? DateTime(
                                                DateTime.now().year -
                                                    int.parse(
                                                      state
                                                              .systemSettingState!
                                                              .settingResponse
                                                              ?.data![
                                                          'member_min_age'],
                                                    ),
                                                state.signUpState!.date!.month,
                                                state.signUpState!.date!.day,
                                              )
                                            : state.signUpState!.date!,
                                        firstDate: DateTime(1970),
                                        lastDate: state.systemSettingState!
                                                .isMinimumAge!
                                            ? DateTime(
                                                DateTime.now().year -
                                                    int.parse(
                                                      state
                                                              .systemSettingState!
                                                              .settingResponse
                                                              ?.data![
                                                          'member_min_age'],
                                                    ),
                                                state.signUpState!.date!.month,
                                                state.signUpState!.date!.day,
                                              )
                                            : state.signUpState!.date!,
                                      );

                                      if (newDate == null) return;
                                      store.dispatch(SignupSetDateTimeAction(
                                          payload: newDate));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: Text(
                                              DateFormat('d MMMM yyyy').format(
                                                  DateTime.parse(state
                                                      .signUpState!.date
                                                      .toString())),
                                              style: Styles.regular_arsenic_14,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: MyTheme.gull_grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Const.height18,

                                // email or phone
                                GroupItemWithChild(
                                  title: isOtpSystem!
                                      ? state.signUpState!.emailOrPhone!
                                          ? "Phone"
                                          : "Email"
                                      : "Email",
                                  style: Styles.bold_app_accent_12,
                                  child: isOtpSystem!
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: MyTheme.solitude,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                          child: state
                                                  .signUpState!.emailOrPhone!
                                              ? InternationalPhoneNumberInput(
                                                  onInputChanged:
                                                      (PhoneNumber number) {
                                                    store.dispatch(
                                                      SignupSetPhoneNumberAction(
                                                          payload: number),
                                                    );
                                                  },
                                                  spaceBetweenSelectorAndTextField:
                                                      0,
                                                  countries: store
                                                      .state.commonState!
                                                      .countriesToString(),
                                                  selectorConfig:
                                                      const SelectorConfig(
                                                          selectorType:
                                                              PhoneInputSelectorType
                                                                  .DIALOG),
                                                  // inputBorder: InputBorder.none,
                                                  inputDecoration: InputStyle
                                                      .inputDecoration_text_field(
                                                    hint: "01XXX XXX XXX",
                                                  ),
                                                )
                                              : TextFormField(
                                                  controller: store
                                                      .state
                                                      .signUpState
                                                      ?.emailController,
                                                  validator: (value) {
                                                    // Check if this field is empty
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter email address';
                                                    }

                                                    // using regular expression
                                                    if (!RegExp(r'\S+@\S+\.\S+')
                                                        .hasMatch(value)) {
                                                      return "Please enter a valid email address";
                                                    }

                                                    // the email is valid
                                                    return null;
                                                  },
                                                  decoration: InputStyle
                                                      .inputDecoration_text_field(
                                                    hint: "johndoe@example.com",
                                                    // suffixIcon: Icon(
                                                    //   Icons.expand_more,
                                                    // )
                                                  ),
                                                ),
                                        )
                                      : TextFormField(
                                          controller: store.state.signUpState
                                              ?.emailController,
                                          validator: (value) {
                                            // Check if this field is empty
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter email address';
                                            }

                                            // using regular expression
                                            if (!RegExp(r'\S+@\S+\.\S+')
                                                .hasMatch(value)) {
                                              return "Please enter a valid email address";
                                            }

                                            // the email is valid
                                            return null;
                                          },
                                          decoration: InputStyle
                                              .inputDecoration_text_field(
                                            hint: "johndoe@example.com",
                                            // suffixIcon: Icon(
                                            //   Icons.expand_more,
                                            // )
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),

                                // change email and password field
                                if (state.addonState?.data?.otpSystem ?? false)
                                  InkWell(
                                    onTap: () {
                                      store.dispatch(
                                          SignupSetEmailOrPhoneAction());
                                    },
                                    child: SizedBox(
                                      width: DeviceInfo(context).width,
                                      child: Text(
                                        isOtpSystem!
                                            ? AppLocalizations.of(context)!
                                                .common_screen_use_email
                                            : state.signUpState!.emailOrPhone!
                                                ? AppLocalizations.of(context)!
                                                    .common_screen_use_phone
                                                : AppLocalizations.of(context)!
                                                    .common_screen_use_email,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 10,
                                          color: MyTheme.app_accent_color,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                // password
                                Const.height18,

                                GroupItemWithChild(
                                  title: AppLocalizations.of(context)!
                                      .common_password_text,
                                  style: Styles.bold_app_accent_12,
                                  child: TextFormField(
                                    controller: store
                                        .state.signUpState?.passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      if (value.length <= 7) {
                                        return "Password should be 8 Charecters long";
                                      }
                                      return null;
                                    },
                                    obscureText: _isObscure,
                                    decoration:
                                        InputStyle.inputDecoratio_password(
                                      hint: ". . . . . . .",
                                      // suffixIcon: Icon(Icons.remove_red_eye),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: DeviceInfo(context).width,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .common_screen_8_or_more_char,
                                    style: Styles.regular_gull_grey_10,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                // confirm password

                                GroupItemWithChild(
                                  title: AppLocalizations.of(context)!
                                      .common_screen_confim_password,
                                  style: Styles.bold_app_accent_12,
                                  child: TextFormField(
                                    controller: store.state.signUpState
                                        ?.confirmPasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Confirm Password';
                                      }
                                      if (store.state.signUpState
                                              ?.passwordController!.text
                                              .toString() !=
                                          store.state.signUpState
                                              ?.confirmPasswordController!.text
                                              .toString()) {
                                        return "Password don't match";
                                      }
                                      return null;
                                    },
                                    obscureText: _isObscure,
                                    decoration:
                                        InputStyle.inputDecoratio_password(
                                      hint: ". . . . . . .",
                                      // suffixIcon: Icon(Icons.remove_red_eye),
                                    ),
                                  ),
                                ),

                                Const.height18,
                                // refer code
                                isReferralSystem!
                                    ? GroupItemWithChild(
                                        title: AppLocalizations.of(context)!
                                            .signup_screen_refer_code,
                                        style: Styles.bold_app_accent_12,
                                        child: TextFormField(
                                          controller: store.state.signUpState
                                              ?.referController,
                                          decoration: InputStyle
                                              .inputDecoration_text_field(
                                            hint: "Type your refer code",
                                            // suffixIcon: Icon(Icons.remove_red_eye),
                                          ),
                                        ),
                                      )
                                    : Const.heightShrink,
                                Const.height18,

                                /// recaptchaf
                                if (settingIsActive(
                                    'google_recaptcha_activation', '1'))
                                  SizedBox(
                                    height: store.state.signUpState!
                                            .isCaptchaShowing!
                                        ? 400
                                        : 50,
                                    width: double.infinity,
                                    child: Captcha(
                                      (keyValue) {
                                        store.dispatch(SetKeyValueAction(
                                            keyValuePayload: keyValue));
                                      },
                                      handleCaptcha: (data) {
                                        if (state.signUpState!.isCaptchaShowing!
                                                .toString() !=
                                            data) {
                                          store.dispatch(
                                              SetIsCaptchaShowingAction(
                                                  payload: data));
                                        }
                                      },
                                      isIOS: Platform.isIOS,
                                    ),
                                  ),
                                GroupItemWithChild(
                                  title: "",
                                  child: SizedBox(
                                    width: DeviceInfo(context).width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0)),
                                            value: state.signUpState!.checkBox,
                                            activeColor:
                                                MyTheme.app_accent_color,
                                            onChanged: (bool? value) {
                                              store.dispatch(
                                                  SignupCheckBoxAction(
                                                      payload: value));
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: DeviceInfo(context).width! / 2,
                                          child: RichText(
                                            text: TextSpan(
                                              // style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .signup_screen_terms_part1,
                                                    style: Styles
                                                        .regular_app_accent_12),
                                                TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            NavigatorPush.push(
                                                              context,
                                                              CommonPrivacyAndTerms(
                                                                title:
                                                                    "Term Conditions Page",
                                                                content: state
                                                                    .staticPageState!
                                                                    .termsAndCondition,
                                                              ),
                                                            );
                                                          },
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .signup_screen_terms_part2,
                                                    style: Styles
                                                        .bold_app_accent_12),
                                                TextSpan(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .signup_screen_terms_part3,
                                                    style: Styles
                                                        .regular_app_accent_12),
                                                TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            NavigatorPush.push(
                                                              context,
                                                              CommonPrivacyAndTerms(
                                                                title:
                                                                    "Privacy Policy Page",
                                                                content: state
                                                                    .staticPageState!
                                                                    .privacyPolicy,
                                                              ),
                                                            );
                                                          },
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .signup_screen_terms_part4,
                                                    style: Styles
                                                        .bold_app_accent_12),
                                              ],
                                            ),
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Const.height40,

                                InkWell(
                                  onTap: () => store.dispatch(
                                      SignUpRequestAction(
                                          payloadContext: context)),
                                  child: Container(
                                    height: 50,
                                    width: DeviceInfo(context).width,
                                    decoration: BoxDecoration(
                                      gradient: Styles.buildLinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: state.signUpState!.isLoading == false
                                        ? Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .signup_screen_button_text_signup,
                                              style: Styles.bold_white_14,
                                            ),
                                          )
                                        : CommonWidget.circularIndicator,
                                  ),
                                ),

                                Const.height40,
                                buildSocialLogin(context),
                                Const.height20,

                                ContactAndFaq(
                                  title: "Frequently Asked Questions (FAQ)",
                                  content: state.staticPageState!.faq,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSocialLogin(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.signup_screen_already_account,
              style: Styles.regular_gull_grey_12,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                ' ${AppLocalizations.of(context)!.signup_screen_login}',
                style: Styles.bold_app_accent_12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const SocialLoginWidget()
      ],
    );
  }

  Container buildGradeintLogo(BuildContext context) {
    return Container(
      height: DeviceInfo(context).height! * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: Styles.buildLinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 78,
          ),
          const ImageIcon(
            AssetImage('assets/logo/app_logo.png'),
            size: 93,
            color: MyTheme.white,
          ),
          Text(
            AppLocalizations.of(context)!.signup_screen_title,
            style: Styles.bold_white_22,
          ),
          Text(
            AppLocalizations.of(context)!.signup_screen_subtitle,
            style: Styles.regular_white_14,
          ),
        ],
      ),
    );
  }
}
