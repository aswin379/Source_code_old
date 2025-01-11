import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/components/navigation_button.dart';
import 'package:active_matrimonial_flutter_app/components/user_profile_action_button.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/member_info/member_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/profile_picture_view_request/profile_picture_view_request_send.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/report/report_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/ignore/add_ignore_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/interest/express_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/shortlist/add_shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/public_profile_expandable_cards/pp_pertner_expectation.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/expandable_lists.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/public_profile_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserPublicProfile extends StatefulWidget {
  final int userId;

  const UserPublicProfile({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserPublicProfile> createState() => _UserPublicProfileState();
}

class _UserPublicProfileState extends State<UserPublicProfile> {
  final TextEditingController _reportController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isAuthUser => store.state.authState!.userData!.id == widget.userId;

  @override
  void initState() {
    super.initState();
    if (!store.state.userVerifyState!.isApprove!) {
      OneContext().pop();
      store.dispatch(
        ShowMessageAction(
          msg: "Please verify your account",
          color: MyTheme.failure,
        ),
      );
    } else {
      store.dispatch(Reset.publicProfile);
      store.dispatch(publicProfileMiddleware(userId: widget.userId));
      store.dispatch(Reset.memberInfo);
      store.dispatch(memberInfoMiddleware(userId: widget.userId));
    }
  }

  void expressLove(AppState state) {
    if (state.accountState!.profileData!.currentPackageInfo!.packageExpiry !=
            "Expired" &&
        state.accountState!.profileData!.remainingInterest != 0) {
      store.dispatch(
        expressInterestMiddleware(userId: widget.userId),
      );
    } else {
      store.dispatch(
        ShowMessageAction(msg: "Please Upgrade your Package"),
      );
    }
  }

  void reportDialogBuilder() {
    OneContext().showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.common_report_member,
            style: Styles.bold_arsenic_14,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.common_report_reason,
                style: Styles.regular_arsenic_14,
              ),
              TextField(
                maxLines: 5,
                controller: _reportController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyTheme.solitude,
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.common_report_reason,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                AppLocalizations.of(context)!.common_cancel,
                style: Styles.regular_arsenic_14,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                AppLocalizations.of(context)!.common_report,
                style: Styles.regular_arsenic_14,
              ),
              onPressed: () {
                store.dispatch(
                  reportMiddleware(
                    userId: widget.userId,
                    reason: _reportController.text,
                  ),
                );
                Navigator.of(context).pop();
                _reportController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  void galleryViewPermission(AppState state) {
    if (state.accountState!.profileData!.currentPackageInfo!.packageExpiry ==
            "Expired" ||
        state.accountState!.profileData!.remainingProfileImageView == 0) {
      store.dispatch(
        ShowMessageAction(
          msg: "Please Upgrade your Package",
        ),
      );
    } else {
      OneContext().showDialog<void>(
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidget.circularIndicator,
                const Text(
                  'Please Wait',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(thickness: 1),
                Text(
                  "Remaining Profile Picture View: ${state.accountState!.profileData!.remainingProfileImageView} times",
                  textAlign: TextAlign.center,
                  style: Styles.regular_gull_grey_12,
                ),
                const SizedBox(height: 5),
                const Text(
                  "N.B. Requesting to See This Member Profile Picture Will Cost 1 From Remaining Profile Picture View.",
                  style: TextStyle(color: Colors.redAccent, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                const Divider(thickness: 1),
              ],
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  backgroundColor: MyTheme.zircon,
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: Styles.buildLinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: MyTheme.white),
                  ),
                ),
                onPressed: () {
                  pleaseWaitDialog();
                  store.dispatch(
                    sendProfilePictureViewRequestAction(id: widget.userId),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget showProfileLockIcon(AppState state) {
    return InkWell(
      onTap: () {
        if (!isAuthUser) {
          galleryViewPermission(state);
        }
      },
      child: Container(
        width: 50.0, // Set width
        height: 50.0, // Set height
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Makes the container circular
          image: DecorationImage(
            image: NetworkImage(state.publicProfileState!.basic?.photo ??
                ''), // Provide the image URL
            fit: BoxFit.cover, // Ensures the image covers the container
          ),
        ),
        child: state.memberInfoState!.memberInfo!.profileViewRequestStatus! !=
                false
            ? Container()
            : Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyTheme.light_grey,
                  ),
                  padding: const EdgeInsets.all(15),
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/icon/icon_lock.png',
                    color: MyTheme.arsenic,
                    height: 25,
                    width: 25,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
      ),
    );
  }

  void pleaseWaitDialog() {
    OneContext().showDialog<void>(
      builder: (BuildContext context) {
        store.state.publicProfileState!.loadingContext = context;
        store.state.publicProfileState!.galleryLoadingContext = context;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.circularIndicator,
              const Text(
                'Please Wait',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return DefaultTabController(
          length: settingIsActive("member_partner_expectation_section", "on")
              ? 3
              : 2,
          child: Scaffold(
            key: _scaffoldKey,
            body: state.publicProfileState!.isFetching! ||
                    state.memberInfoState!.isFetching!
                ? CommonWidget.circularIndicator
                : Column(
                    children: [
                      buildProfileHeader(state, context),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ExpandableLists(userId: widget.userId),
                            if (settingIsActive(
                                "member_partner_expectation_section", "on"))
                              const PP_PartnerExpectation(),
                            UserGallery(
                              state: state,
                              isAuthUser: isAuthUser,
                              userId: widget.userId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Container buildProfileHeader(AppState state, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.8, 1),
          colors: [
            MyTheme.gradient_color_1,
            MyTheme.gradient_color_2,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
          child: Column(
            children: [
              _buildProfileHeaderRow(state, context),
              const SizedBox(height: 10),
              const Divider(color: Colors.white),
              const SizedBox(height: 10),
              _buildProfileDetailsRow(state, context),
              const SizedBox(height: 10),
              _buildTabBar(),
              const SizedBox(height: 18),
              if (!isAuthUser) _buildActionButtons(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildProfileHeaderRow(AppState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProfileInfo(state),
        if (!isAuthUser) _buildInterestButton(state),
      ],
    );
  }

  Row _buildProfileInfo(AppState state) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/icon/icon_pop_white.png',
            height: 20,
            width: 20,
          ),
        ),
        const SizedBox(width: 10),
        if (state.publicProfileState != null &&
            state.publicProfileState!.profilePicRequest)
          showProfileLockIcon(state)
        else
          _buildProfileImage(state),
        const SizedBox(width: 10),
        _buildProfileNameAndID(state),
      ],
    );
  }

  SizedBox _buildProfileImage(AppState state) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: MyImages.normalImage(state.publicProfileState!.basic?.photo),
      ),
    );
  }

  Column _buildProfileNameAndID(AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.publicProfileState!.basic?.firsName ?? '',
          style: Styles.bold_white_14,
        ),
        Row(
          children: [
            Text(
              "Member ID ",
              style: Styles.regular_light_grey_12,
            ),
            Text(
              state.publicProfileState!.basic?.code ?? '--',
              style: Styles.regular_white_12,
            ),
          ],
        ),
      ],
    );
  }

  Container _buildInterestButton(AppState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: 40,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () => expressLove(state),
        icon: SizedBox(
          height: 18,
          width: 18,
          child: state.myInterestState!.isLoading!
              ? const CircularProgressIndicator(
                  color: MyTheme.white,
                  strokeWidth: 1,
                )
              : state.memberInfoState!.memberInfo!.interestStatus ==
                      "received interest"
                  ? Image.asset('assets/icon/icon_love_full.png')
                  : Image.asset('assets/icon/icon_love.png'),
        ),
      ),
    );
  }

  Row _buildProfileDetailsRow(AppState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${state.publicProfileState!.basic?.age ?? ''} yrs, ${state.publicProfileState!.physical?.height ?? ''} ft, ${state.publicProfileState!.basic?.maritialStatus ?? ''}",
              style: Styles.regular_white_12,
            ),
            Text(
              "${state.publicProfileState!.spiritual?.religionId ?? ''} ${state.publicProfileState!.spiritual?.casteId ?? ''}",
              style: Styles.regular_white_12,
            ),
          ],
        ),
        if (!isAuthUser && state.publicProfileState!.profilematch != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.public_profile,
                style: Styles.regular_white_12,
              ),
              Text(
                "${state.publicProfileState!.profilematch ?? 0} %",
                style: Styles.bold_white_30,
              ),
            ],
          ),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      isScrollable: true,
      dividerHeight: 0.0,
      tabAlignment: TabAlignment.start,
      indicatorColor: Colors.transparent,
      tabs: [
        const Tab(child: NavigationButton(text: 'Full profile')),
        if (settingIsActive("member_partner_expectation_section", "on"))
          const Tab(child: NavigationButton(text: 'Partner Preferences')),
        const Tab(child: NavigationButton(text: 'Gallery')),
      ],
    );
  }

  Column _buildActionButtons(BuildContext context, state) {
    return Column(
      children: [
        const Divider(color: Colors.white),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UserProfileActionButton(
              onTap: reportDialogBuilder,
              text: state.memberInfoState!.memberInfo!.reportStatus!
                  ? AppLocalizations.of(context)!.my_profile_reported
                  : AppLocalizations.of(context)!.my_profile_report,
              icon: 'icon_report.png',
            ),
            UserProfileActionButton(
              onTap: () => store.dispatch(
                addShortlistMiddleware(userId: widget.userId),
              ),
              text: state.memberInfoState!.memberInfo!.shortlistStatus == 1
                  ? AppLocalizations.of(context)!.common_shortlisted
                  : AppLocalizations.of(context)!.common_shortlist,
              icon: 'icon_shortlist_black.png',
            ),
            UserProfileActionButton(
              onTap: () => store.dispatch(
                addIgnoreMiddleware(userId: widget.userId, from: 'userprofile'),
              ),
              text: AppLocalizations.of(context)!.my_profile_ignore_user,
              icon: 'icon_ignore_users.png',
            ),
          ],
        ),
      ],
    );
  }
}
