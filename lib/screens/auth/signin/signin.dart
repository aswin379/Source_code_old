import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/social_login_widget.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/shared_pref.dart';
import 'package:active_matrimonial_flutter_app/main.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_check_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_action.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../components/contact_faq_widget.dart';
import '../../../components/group_item_with_child.dart';
import '../../../components/my_gradient_container.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/main_helpers.dart';
import '../../../redux/libs/staticPage/static_page.dart';
import '../forgetPassword/forget_password.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? isGoogle = settingIsActive('google_login_activation', '1');
  bool? isFacebook = settingIsActive('facebook_login_activation', '1');
  bool? isTwitter = settingIsActive('twitter_login_activation', "1");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) => [
          store.dispatch(fetchStaticPageAction()),
          SharedPref().isView = true,
          store.dispatch(featureCheckMiddleware()),
        ],
        builder: (_, state) => SizedBox(
            height: DeviceInfo(context).height,
            child: buildBody(context, state)),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return Stack(
      children: [
        buildGradientContainer(context),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroupItemWithChild(
                          title: isOtpSystem!
                              ? state.signInState!.isPhone!
                                  ? "Phone"
                                  : "Email"
                              : "Email",
                          style: Styles.bold_app_accent_12,
                          child: isOtpSystem!
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: MyTheme.solitude,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                  ),
                                  child: state.signInState!.isPhone!
                                      ? InternationalPhoneNumberInput(
                                          onInputChanged: (PhoneNumber number) {
                                            store.dispatch(
                                              SetPhoneNumberAction(
                                                payload: number.phoneNumber,
                                              ),
                                            );
                                          },
                                          countries: store.state.commonState!
                                              .countriesToString(),
                                          spaceBetweenSelectorAndTextField: 0,
                                          selectorConfig: const SelectorConfig(
                                            selectorType:
                                                PhoneInputSelectorType.DIALOG,
                                          ),
                                          inputDecoration: InputDecoration(
                                            filled: true,
                                            fillColor: MyTheme.solitude,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            isDense: true,
                                            hintText: "01XXX XXX XXX",
                                            hintStyle:
                                                Styles.regular_gull_grey_12,
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                          ),
                                        )
                                      : TextField(
                                          controller: store.state.signInState!
                                              .emailController,
                                          onTap: () {
                                            store.dispatch(ClearAction());
                                          },
                                          decoration: InputStyle
                                              .inputDecoration_text_field(
                                            hint: "johndoe@example.com",
                                          ),
                                        ),
                                )
                              : TextField(
                                  controller:
                                      store.state.signInState!.emailController,
                                  onTap: () {
                                    store.dispatch(ClearAction());
                                  },
                                  decoration:
                                      InputStyle.inputDecoration_text_field(
                                    hint: "johndoe@example.com",
                                  ),
                                ),
                        ),
                        Const.height5,
                        if (state.addonState?.data?.otpSystem ?? false)
                          InkWell(
                            onTap: () {
                              store.dispatch(IsPhoneOrEmailChangeAction());
                            },
                            child: SizedBox(
                              width: DeviceInfo(context).width,
                              child: Text(
                                isOtpSystem!
                                    ? state.signInState!.isPhone!
                                        ? AppLocalizations.of(context)!
                                            .common_screen_use_email
                                        : AppLocalizations.of(context)!
                                            .common_screen_use_phone
                                    : AppLocalizations.of(context)!
                                        .common_screen_use_email,
                                textAlign: TextAlign.right,
                                style: Styles.italic_app_accent_10_underline,
                              ),
                            ),
                          ),
                        Column(
                          children: [
                            Const.height5,
                            SizedBox(
                              width: DeviceInfo(context).width,
                              child: Text(
                                state.signInState!.emailErrorText!,
                                style: TextStyle(
                                    color: MyTheme.failure, fontSize: 11),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),

                        Const.height5,

                        GroupItemWithChild(
                          title: AppLocalizations.of(context)!
                              .common_password_text,
                          style: Styles.bold_app_accent_12,
                          child: TextField(
                            controller: state.signInState!.passwordController,
                            obscureText: state.signInState!.isObscure!,
                            decoration: InputStyle.inputDecoratio_password(
                              hint: ". . . . . . . .",
                              suffixIcon: GestureDetector(
                                onTap: () => store.dispatch(IsObscureAction()),
                                child: Icon(state.signInState!.isObscure!
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Const.height5,
                            SizedBox(
                              width: DeviceInfo(context).width,
                              child: Text(
                                state.signInState!.passwordErrorText!,
                                style: TextStyle(
                                    color: MyTheme.failure, fontSize: 11),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        // forget password
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgetPassword()),
                            );
                          },
                          child: SizedBox(
                            width: DeviceInfo(context).width,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .login_screen_forget_password,
                              style: Styles.italic_app_accent_10_underline,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     Const.height5,
                        //     SizedBox(
                        //       width: DeviceInfo(context).width,
                        //       child: Text(
                        //         state.signInState!.passwordErrorText!,
                        //         style: TextStyle(
                        //             color: MyTheme.failure, fontSize: 11),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () => store
                              .dispatch(LoginRequest(payloadContext: context)),
                          child: MyGradientContainer(
                            text: state.signInState!.isLogin == false
                                ? Text(
                                    AppLocalizations.of(context)!
                                        .login_button_text,
                                    style: Styles.bold_white_14,
                                  )
                                : CircularProgressIndicator(
                                    color: MyTheme.storm_grey,
                                  ),
                          ),
                        ),

                        const SizedBox(
                          height: 40,
                        ),

                        /// sign in if not have account to login
                        others(context, state),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget others(BuildContext context, AppState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.login_screen_if_have_account,
              style: Styles.regular_gull_grey_12,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                );
              },
              child: Text(
                ' ${AppLocalizations.of(context)!.login_screen_signup}',
                style: Styles.bold_app_accent_12,
              ),
            ),
          ],
        ),
        Const.height10,

        /// social button google facebook twitter
        const SocialLoginWidget(),
        Const.height20,

        ContactAndFaq(
          title: "Frequently Asked Questions (FAQ)",
          content: state.staticPageState!.faq,
        )
      ],
    );
  }

  Widget buildGradientContainer(BuildContext context) {
    return Container(
      height: DeviceInfo(context).height! * 0.50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: Styles.buildLinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
            AppLocalizations.of(context)!.login_text_title,
            style: Styles.bold_white_22,
          ),
          Text(
            AppLocalizations.of(context)!.login_text_sub_title,
            style: Styles.regular_white_14,
          ),
        ],
      ),
    );
  }
}
