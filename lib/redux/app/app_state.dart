import 'package:active_matrimonial_flutter_app/redux/libs/add_on/addon_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/app_info/app_info_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/reset_password_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/auth/vertify_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/contact_view/contact_view_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/feature/feature_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/helpers/show_message_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/manage_profile_combine_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/matched_profile/matched_profile_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/member_info/member_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_state.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/staticPage/static_page.dart';
import 'package:active_matrimonial_flutter_app/screens/account/account_state.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/change_password/change_password_state.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/forgetPassword/forgetpassword_state.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin_state.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signup/signup_state.dart';
import 'package:active_matrimonial_flutter_app/screens/blog/blog_state.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_details_state.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_state.dart';
import 'package:active_matrimonial_flutter_app/screens/contact_us/contact_us_state.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/happy_stories_state.dart';
import 'package:active_matrimonial_flutter_app/screens/happy_story/my_happy_stories/my_happy_story_state.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/explore/explore_state.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/home/home_state.dart';
import 'package:active_matrimonial_flutter_app/screens/ignore/ignore_state.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/gallery/gallery_image_state.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/interest/my_interest_state.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/shortlist/shortlist_state.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/wallet/my_wallet_state.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications/notification_state.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_details_state.dart';
import 'package:active_matrimonial_flutter_app/screens/package/package_state.dart';
import 'package:active_matrimonial_flutter_app/screens/package/premium_plans_state.dart';
import 'package:active_matrimonial_flutter_app/screens/payment_methods/payment_types_state.dart';
import 'package:active_matrimonial_flutter_app/screens/profile_and_gallery_picure_rqst/gallery_picture_view_state.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_earning_state.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_state.dart';
import 'package:active_matrimonial_flutter_app/screens/referral/referral_withdraw_request_history_state.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/basic_search_state.dart';
import 'package:active_matrimonial_flutter_app/screens/startup_pages/landing_page/landing.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket_create_state.dart';
import 'package:active_matrimonial_flutter_app/screens/support_ticket/support_ticket_state.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/public_profile_state.dart';
import 'package:flutter/material.dart';

import '../../screens/auth/verify/verify_state.dart';
import '../../screens/my_dashboard_pages/interest_request/interest_request_state.dart';
import '../../screens/my_dashboard_pages/wallet/package_payment_with_wallet.dart';
import '../../screens/others/offline/offline_payment_state.dart';
import '../libs/auth/authstate.dart';
import '../libs/common/common_state.dart';

@immutable
class AppState {
  final UserVerifyState? userVerifyState;
  final StaticPageState? staticPageState;
  final ContactUsState? contactUsState;
  final MatchedProfileState? matchedProfileState;
  final MemberInfoState? memberInfoState;
  final PictureProfileViewState? pictureProfileViewState;
  final GalleryPictureViewState? galleryPictureViewState;
  final AddonState? addonState;
  final ChatDetailsState? chatDetailsState;
  final ShowMessageState? showMessageState;
  final SignUpState? signUpState;
  final AuthState? authState;
  final LandingState? landingState;
  final BasicSearchState? basicSearchState;
  final SignInState? signInState;
  final NotificationState? notificationState;
  final ReferralState? referralState;
  final ForgetPasswordState? forgetPasswordState;
  final VerifyState? verifyState;
  final ResetPasswordState? resetPasswordState;
  final AccountState? accountState;
  final BlogState? blogState;
  final ExploreState? exploreState;
  final HomeState? homeState;
  final MyInterestState? myInterestState;
  final InterestRequestState? interestRequestState;
  final ShortlistState? shortlistState;
  final HappyStoriesState? happyStoriesState;
  final ChatState? chatState;
  final GalleryImageState? galleryImageState;
  final PackageState? packageState;
  final IgnoreState? ignoreState;
  final AppInfoState? appInfoState;
  final MyWalletState? myWalletState;
  final MyHappyStoryState? myHappyStoryState;
  final SupportTicketState? supportTicketState;
  final ManageProfileCombineState? manageProfileCombineState;
  final PublicProfileState? publicProfileState;
  final PaymentTypesState? paymentTypesState;
  final PremiumPlansState? premiumPlansState;
  final ChangePasswordState? changePasswordState;
  final PackageDetailsState? packageDetailsState;
  final ReferralEarningState? referralEarningState;
  final SystemSettingState? systemSettingState;
  final ContactViewState? contactViewState;
  final SupportTicketCreateState? supportTicketCreateState;
  final SupportTicketReplyState? supportTicketReplyState;
  final ReferralWithdrawRequestHistoryState?
      referralWithdrawRequestHistoryState;
  final PackagePaymentWithWalletState? packagePaymentWithWalletState;
  CommonState? commonState;
  final OfflinePaymentState? offlinePaymentState;

  AppState(
      {this.staticPageState,
      this.userVerifyState,
      this.contactUsState,
      this.offlinePaymentState,
      this.packagePaymentWithWalletState,
      this.memberInfoState,
      this.matchedProfileState,
      this.signUpState,
      this.landingState,
      this.galleryPictureViewState,
      this.referralWithdrawRequestHistoryState,
      this.contactViewState,
      this.supportTicketCreateState,
      this.referralEarningState,
      this.supportTicketReplyState,
      this.pictureProfileViewState,
      this.addonState,
      this.chatDetailsState,
      this.systemSettingState,
      this.changePasswordState,
      this.appInfoState,
      this.interestRequestState,
      this.packageDetailsState,
      this.premiumPlansState,
      this.paymentTypesState,
      this.showMessageState,
      this.basicSearchState,
      this.notificationState,
      this.publicProfileState,
      this.supportTicketState,
      this.myWalletState,
      this.myHappyStoryState,
      this.packageState,
      this.galleryImageState,
      this.referralState,
      this.signInState,
      this.forgetPasswordState,
      this.verifyState,
      this.manageProfileCombineState,
      this.resetPasswordState,
      this.accountState,
      this.blogState,
      this.exploreState,
      this.homeState,
      this.myInterestState,
      this.shortlistState,
      this.happyStoriesState,
      this.ignoreState,
      this.chatState,
      this.authState,
      this.commonState});

  AppState.initialState()
      : signUpState = SignUpState.initialState(),
        userVerifyState = UserVerifyState.initialState(),
        offlinePaymentState = OfflinePaymentState.initialState(),
        staticPageState = StaticPageState.initialState(),
        contactUsState = ContactUsState.initialState(),
        packagePaymentWithWalletState =
            PackagePaymentWithWalletState.initialState(),
        memberInfoState = MemberInfoState.initialState(),
        matchedProfileState = MatchedProfileState.initialState(),
        addonState = AddonState.initialState(),
        landingState = LandingState.initialState(),
        galleryPictureViewState = GalleryPictureViewState.initial(),
        supportTicketCreateState = SupportTicketCreateState.initialState(),
        supportTicketReplyState = SupportTicketReplyState.initialState(),
        contactViewState = ContactViewState.initialState(),
        referralWithdrawRequestHistoryState =
            ReferralWithdrawRequestHistoryState.initialState(),
        showMessageState = ShowMessageState.initialState(),
        pictureProfileViewState = PictureProfileViewState.initial(),
        systemSettingState = SystemSettingState.initialState(),
        packageDetailsState = PackageDetailsState.initialState(),
        changePasswordState = ChangePasswordState.initialState(),
        referralEarningState = ReferralEarningState.initialState(),
        chatDetailsState = ChatDetailsState.initialState(),
        paymentTypesState = PaymentTypesState.initialState(),
        interestRequestState = InterestRequestState.initialState(),
        premiumPlansState = PremiumPlansState.initialState(),
        referralState = ReferralState.initialState(),
        notificationState = NotificationState.initialState(),
        appInfoState = AppInfoState.initialState(),
        basicSearchState = BasicSearchState.initialState(),
        supportTicketState = SupportTicketState.initialState(),
        publicProfileState = PublicProfileState.initialState(),
        myWalletState = MyWalletState.initialState(),
        myHappyStoryState = MyHappyStoryState.initialState(),
        signInState = SignInState.initialState(),
        galleryImageState = GalleryImageState.initialState(),
        forgetPasswordState = ForgetPasswordState.initialState(),
        verifyState = VerifyState.initialState(),
        manageProfileCombineState = ManageProfileCombineState.initialState(),
        resetPasswordState = ResetPasswordState.initialState(),
        accountState = AccountState.initialState(),
        blogState = BlogState.initialState(),
        exploreState = ExploreState.initialState(),
        homeState = HomeState.initialState(),
        packageState = PackageState.initialState(),
        ignoreState = IgnoreState.initialState(),
        myInterestState = MyInterestState.initialState(),
        shortlistState = ShortlistState.initialState(),
        happyStoriesState = HappyStoriesState.initialState(),
        authState = null,
        commonState = CommonState(),
        chatState = ChatState.initialState();
}
