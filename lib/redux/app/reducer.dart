import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_api_request.dart';
import 'package:active_matrimonial_flutter_app/helpers/shared_pref.dart';
import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/auth_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/verify_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/contact_view/contact_view_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/manage_profile_combine_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_reducer.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/staticPage/static_page.dart';
import 'package:active_matrimonial_flutter_app/screens/account/account_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/change_password/change_password_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/forgetPassword/forgetpassword_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup/signup_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blog_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_details_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/happy_stories_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/my_happy_stories/my_happy_story_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/explore/explore_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/home/home_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/ignore/ignore_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/gallery/gallery_image_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/interest/my_interest_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/interest_request/interest_request_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/shortlist/shortlist_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/wallet/my_wallet_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/wallet/package_payment_with_wallet.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications/notification_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/others/offline/offline_payment_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_details_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/package/premium_plans_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/payment_types_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/profile_and_gallery_picure_rqst/gallery_picture_view_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_earning_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_withdraw_request_history_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/basic_search_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/landing_page/landing.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket_create_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/public_profile_reducer.dart';

import '../../screens/auth/verify/verify_reducer.dart';
import '../../screens/contact_us/contact_us_reducer.dart';
import '../libs/add_on/addon_reducer.dart';
import '../libs/common/common_states_reducer.dart';
import '../libs/matched_profile/matched_profile_reducer.dart';
import '../libs/member_info/member_info.dart';

AppState reducer(AppState state, dynamic action) {
  var accessToken = SharedPref().accessToken;
  AizApi.get(Uri.parse("${AppConfig.BASE_URL}/app-check"), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $accessToken",
  });

  return AppState(
      signUpState: sign_up_reducer(state.signUpState, action),
      userVerifyState: userVerifyReducer(state.userVerifyState!, action),
      offlinePaymentState:
          offlinePaymentReducer(state.offlinePaymentState, action),
      contactUsState: contact_us_reducer(state.contactUsState, action),
      packagePaymentWithWalletState:
          ppwws_reducer(state.packagePaymentWithWalletState, action),
      staticPageState: staticPageReducer(state.staticPageState, action),
      showMessageState: show_message_reducer(state.showMessageState, action),
      memberInfoState: member_info_reducer(state.memberInfoState, action),
      matchedProfileState:
          matched_profile_state(state.matchedProfileState, action),
      publicProfileState:
          public_profile_reducer(state.publicProfileState, action),
      contactViewState: contact_view_reducer(state.contactViewState, action),
      paymentTypesState: payment_types_reducer(state.paymentTypesState, action),
      signInState: sign_in_reducer(state.signInState, action),
      referralEarningState:
          referralEarningReducer(state.referralEarningState, action),
      packageDetailsState:
          package_details_reducer(state.packageDetailsState, action),
      forgetPasswordState:
          forgetpassword_reducer(state.forgetPasswordState, action),
      premiumPlansState: premium_plans_reducer(state.premiumPlansState, action),
      basicSearchState: basic_search_reducer(state.basicSearchState, action),
      referralState: referral_reducer(state.referralState, action),
      landingState: landingReducer(state.landingState, action),
      verifyState: verify_reducer(state.verifyState, action),
      chatDetailsState: chat_details_reducer(state.chatDetailsState, action),
      appInfoState: app_info_reducer(state.appInfoState, action),
      changePasswordState:
          change_password_reducer(state.changePasswordState, action),
      manageProfileCombineState: manage_profile_combine_reducer(
          state.manageProfileCombineState, action),
      referralWithdrawRequestHistoryState:
          referral_withdraw_request_history_reducer(
              state.referralWithdrawRequestHistoryState, action),
      notificationState: notification_reducer(state.notificationState, action),
      myWalletState: my_wallet_reducer(state.myWalletState, action),
      myHappyStoryState:
          my_happy_story_reducer(state.myHappyStoryState, action),
      supportTicketState:
          support_ticket_reducer(state.supportTicketState, action),
      resetPasswordState:
          reset_password_reducer(state.resetPasswordState, action),
      galleryImageState: gallery_image_reducer(state.galleryImageState, action),
      accountState: account_reducer(state.accountState, action),
      blogState: blog_reducer(state.blogState, action),
      exploreState: explore_reducer(state.exploreState, action),
      homeState: home_reducer(state.homeState, action),
      packageState: package_reducer(state.packageState, action),
      myInterestState: my_interest_reducer(state.myInterestState, action),
      interestRequestState:
          interest_request_reducer(state.interestRequestState, action),
      shortlistState: shortlist_reducer(state.shortlistState, action),
      ignoreState: ignore_reducer(state.ignoreState, action),
      systemSettingState: feature_reducer(state.systemSettingState, action),
      addonState: addon_reducer(state.addonState, action),
      happyStoriesState: happy_stories_reducer(state.happyStoriesState, action),
      chatState: chat_reducer(state.chatState, action),
      supportTicketCreateState:
          support_ticket_create_reducer(state.supportTicketCreateState, action),
      supportTicketReplyState:
          support_ticket_reply_reducer(state.supportTicketReplyState, action),
      galleryPictureViewState:
          gallery_picture_view_reducer(state.galleryPictureViewState, action),
      pictureProfileViewState:
          profile_picture_view_reducer(state.pictureProfileViewState, action),
      authState: authReducer(state.authState, action),
      commonState: commonStateCountryReducer(state.commonState, action));
}
