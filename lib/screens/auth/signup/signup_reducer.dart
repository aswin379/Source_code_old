import 'package:active_matrimonial_flutter_app/screens/auth/signup/signup_action.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup/signup_state.dart';

import '../../../helpers/data_time_format.dart';
import '../../core.dart';
import 'signup_middleware.dart';

SignUpState? sign_up_reducer(SignUpState? state, dynamic action) {
  if (action is SignupReset) {
    return state?.copyWith(
        firstNameController: "",
        lastNameController: "",
        emailController: "",
        passwordController: "",
        phoneNumber: "",
        confirmPasswordController: "",
        checkBox: false);
  }

  if (action is SignUpRequestAction) {
    if (state!.checkBox == false) {
      store.dispatch(
        ShowMessageAction(
          msg: 'Agree to terms and condition!',
        ),
      );
    } else if (state.signUpFormKey.currentState!.validate()) {
      if (state.currentGender == "Male") {
        state.genderController!.text = "1";
      } else {
        state.genderController!.text = "2";
      }

      bool isOtp = store.state.addonState!.data!.otpSystem ?? false;
      var emailOrPhone = isOtp
          ? state.emailOrPhone!
              ? state.phoneNumber
              : state.emailController!.text
          : state.emailController!.text;

      store.dispatch(
        signupMiddleware(
          action.payloadContext,
          firstName: state.firstNameController!.text,
          lastName: state.lastNameController!.text,
          emailOrPhone: emailOrPhone,
          emailOrPhoneText: state.emailOrPhone! ? "phone" : "email",
          onBehalf: state.on_behalves_value,
          gender: state.genderController!.text,
          dateOfBirth: yearMonthDay(state.date!),
          password: state.passwordController!.text,
          passwordConfirmation: state.confirmPasswordController!.text,
          referral: state.referController!.text,
          recapthca: state.googleRecaptchaKey,
        ),
      );
    }
    return state;
  }
  if (action is SignUpAction) {
    return loader(state!, action);
  }
  if (action is SignupSetPhoneNumberAction) {
    state?.phoneNumber = action.payload!.phoneNumber;
    return state;
  }
  if (action is SignupSetDateTimeAction) {
    state?.date = action.payload!;
    return state;
  }
  if (action is SignupSetOnBehalvesAction) {
    state?.on_behalves_value = action.payload;
    return state;
  }
  if (action is SignupSetGenderAction) {
    state!.currentGender = action.payload;
    return state;
  }
  if (action is SignupCheckBoxAction) {
    state!.checkBox = !state.checkBox!;
    return state;
  }
  if (action is SignupSetEmailOrPhoneAction) {
    state!.emailOrPhone = !state.emailOrPhone!;
    return state;
  }
  if (action is SignupStoreOnBehalfAction) {
    state!.onBehalfList = action.payload!.data;
    state.on_behalves_value = state.onBehalfList!.first.id;
    return state;
  }

  if (action is SetKeyValueAction) {
    state!.googleRecaptchaKey = action.keyValuePayload;
    return state;
  }
  if (action is SetIsCaptchaShowingAction) {
    state!.isCaptchaShowing = action.payload;
    return state;
  }

  return state;
}

loader(SignUpState state, SignUpAction action) {
  state.isLoading = !state.isLoading!;
  return state;
}
