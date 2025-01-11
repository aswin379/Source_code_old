import 'dart:io';

import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/container_with_icon.dart';
import 'package:active_matrimonial_flutter_app/components/custom_popup.dart';
import 'package:active_matrimonial_flutter_app/components/my_circular_indicator.dart';
import 'package:active_matrimonial_flutter_app/components/my_images.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_route.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/helpers/navigator_push.dart';
import 'package:active_matrimonial_flutter_app/middleware/profile_view_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/report/report_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/account/account_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/home/home_action.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/home/home_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/interest/express_interest_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/shortlist/add_shortlist_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/notifications/notifications.dart';
import 'package:active_matrimonial_flutter_app/screens/search_screens/search.dart';
import 'package:active_matrimonial_flutter_app/screens/user_pages/user_public_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app_config.dart';
import '../../../helpers/shared_pref.dart';
import '../../auth/verify/verify_action.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  onRefresh() {
    store.dispatch(accountMiddleware());
    store.dispatch(homeMiddleware());
  }

  @override
  void initState() {
    super.initState();
    store.dispatch(accountMiddleware());
    store.dispatch(getUserIsApproveAction());
    store.dispatch(homeMiddleware());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // screen height and width
    double? screenHeight = DeviceInfo(context).height;
    double? screenWidth = DeviceInfo(context).width;

    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel.fromStore(store),
      builder: (_, HomeViewModel vm) => WillPopScope(
        onWillPop: () async {
          final shouldPop = (await OneContext().showDialog<bool>(
            builder: (BuildContext context) {
              return exit_alert_dialog(context);
            },
          ))!;
          return shouldPop;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(context, screenHeight, screenWidth)
              as PreferredSizeWidget?,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () {
                onRefresh();
                return Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: DeviceInfo(context).height! -
                      (AppBar().preferredSize.height + 100),
                  padding: EdgeInsets.only(
                      left: Const.kPaddingHorizontal,
                      right: Const.kPaddingHorizontal,
                      bottom: Const.kPaddingHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Const.height10,

                      // main  container with image
                      if (vm.activeMembers == null || vm.activeMembers == [])
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.app_accent_color),
                          onPressed: () {
                            onRefresh();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Something went wrong reload it"),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.refresh),
                            ],
                          ),
                        )
                      else
                        vm.isFetch == false
                            ? view_card(vm, context, screenWidth)
                            : Center(
                                child: CircularProgressIndicator(
                                  color: MyTheme.storm_grey,
                                ),
                              ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget view_card(HomeViewModel vm, BuildContext context, double? width) {
    return Expanded(
      child: vm.activeMembers!.isNotEmpty
          ? PageView.builder(
              controller: vm.controller,
              itemCount: vm.activeMembers!.length,
              itemBuilder: (listViewContext, index) {
                var members = vm.activeMembers!;
                return Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MyImage.imageProvider(members[index].photo),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.4,
                              1,
                            ],
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: DeviceInfo(context).width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // named row
                                buildNameAndId(members, index, vm, width),

                                // age, height, location and full profile row
                                buildAgeAndFullProfileRow(
                                    members, index, vm, context),
                                Const.height10,
                                // page navigator with subscribe, love and follow button
                                buildPageNavigatorWithSubscribeLoveFollow(
                                    context, index, members[index], vm),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              },
              onPageChanged: (index) {
                store.dispatch(SetCurrentIndex(payload: index));
                SharedPref().showDialog = false;
              },
            )
          : CommonWidget.noData,
    );
  }

  Widget buildAgeAndFullProfileRow(List<dynamic> members, int index,
      HomeViewModel vm, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ImageIcon(
                  AssetImage('assets/icon/icon_person.png'),
                  size: 12,
                  color: MyTheme.white,
                ),
                Const.width5,
                // age and height row
                Text(
                  // TODO INch WILL BE HERE
                  '${members[index].age} yrs, ${members[index].height} ft',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                const ImageIcon(
                  AssetImage('assets/icon/icon_location.png'),
                  size: 12,
                  color: MyTheme.white,
                ),
                Const.width5,
                Text(
                  '${members[index].country}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),

        /// full profile button
        TextButton(
          onPressed: () {
            AIZRoute.push(
                context,
                UserPublicProfile(
                  userId: members[index].userId,
                ),
                middleware: ProfileViewMiddleware(
                    context: context, user: store.state.authState?.userData));
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            side: MaterialStateProperty.all(
                const BorderSide(color: Colors.white)),
          ),
          child: Text(
            AppLocalizations.of(context)!.home_screen_full_profile,
            style: Styles.bold_white_12,
          ),
        ),
      ],
    );
  }

  Widget buildNameAndId(
      List<dynamic> members, int index, HomeViewModel vm, double? width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                members[index].name == ''
                    ? const Text('')
                    : width! > 350
                        ? Text(
                            '${members[index].name}',
                            style: Styles.bold_white_16,
                          )
                        : Text(
                            '${members[index].name}',
                            style: Styles.bold_white_14,
                          ),
                Const.height7,
                members[index].membership == 2
                    ? ImageIcon(
                        const AssetImage('assets/icon/icon_premium.png'),
                        size: 18,
                        color: MyTheme.icon_premium_color,
                      )
                    : const SizedBox(),
              ],
            ),
            Const.height7,
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.common_screen_member_id,
                  style: const TextStyle(color: MyTheme.white),
                ),
                Text(
                  members[index].code,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
        Container(
          alignment: Alignment.centerRight,
          child: PopupMenuButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            child: const SizedBox(
              width: 16,
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
            onSelected: (dynamic value) {
              switch (value.toString().toLowerCase()) {
                case 'report':
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return buildAlertDialog(
                          context, vm.activeMembers![index], vm);
                    },
                  );

                  break;
              }
            },
            itemBuilder: (context) {
              return ['Report']
                  .map(
                    (e) => PopupMenuItem(
                      height: 30,
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        )
      ],
    );
  }

  Widget blackShadeOverImage() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.4,
              1,
            ],
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }

  Widget exit_alert_dialog(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.exit,
          style: Styles.bold_arsenic_14),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () {
            // Navigator.pop(context, true);
            Platform.isAndroid ? SystemNavigator.pop() : exit(0);
          },
          child: Text('Yes', style: Styles.regular_arsenic_14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('No', style: Styles.regular_arsenic_14),
        ),
      ],
    );
  }

  Widget buildAlertDialog(BuildContext context, user, HomeViewModel vm) {
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
            controller: vm.reportController,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyTheme.solitude,
              border: InputBorder.none,
            ),
          )
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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(AppLocalizations.of(context)!.common_report,
              style: Styles.regular_arsenic_14),
          onPressed: () {
            vm.userReport!(
                user: user.userId, reason: vm.reportController!.text);
            Navigator.of(context).pop();
            vm.reportController!.clear();
          },
        ),
      ],
    );
  }

  Widget buildAppBar(BuildContext context, double? height, double? width) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: Const.kPaddingHorizontal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo/appbar_logo.png',
                  fit: BoxFit.contain,
                  height: width! > 350 ? 36 : 30,
                  width: width > 350 ? 46 : 40,
                ),
                const SizedBox(
                  width: 8.3,
                ),
                buildAppName(width!)
              ],
            ),
            Row(
              children: [
                CommonWidget.social_button(
                    gradient: Styles.buildLinearGradient(
                        begin: Alignment.topLeft, end: Alignment.bottomRight),
                    icon: "icon_bell.png",
                    onpressed: () {
                      SharedPref().isLoggedIn
                          ? NavigatorPush.push(context, const Notifications())
                          : CustomPopUp(context).loginDialog(context);
                    }),
                const SizedBox(
                  width: 8.0,
                ),
                CommonWidget.social_button(
                  gradient: Styles.buildLinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                  icon: "icon_search.png",
                  onpressed: () {
                    SharedPref().isLoggedIn
                        ? showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const SizedBox(
                                  height: 1000, child: Search());
                            },
                          )
                        : CustomPopUp(context).loginDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildAppName(sw) {
    // for
    if (sw > 350) {
      // widgets for larger screen
      return Text(
        AppConfig.app_name,
        style: Styles.bold_app_accent_16,
      );
    } else {
      // widgets for smaller screen

      return Text(
        AppConfig.app_name,
        style: const TextStyle(
            fontSize: 10,
            color: MyTheme.app_accent_color,
            fontWeight: FontWeight.bold),
      );
    }
  }

  Widget buildPageNavigatorWithSubscribeLoveFollow(
      BuildContext context, int index, dynamic user, HomeViewModel vm) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      /// go to left
      ContainerWithIcon(
        onpressed: () {
          vm.goToPrev!();
        },
        icon: 'icon_left.png',
        width: 40,
        height: 40,
        radius: 20,
        opacity: 0.1,
        color: Colors.white,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// add to ignore
          ContainerWithIcon(
            onpressed: () {
              if (!store.state.userVerifyState!.isApprove!) {
                store.dispatch(
                  ShowMessageAction(
                    msg: "Please verify your account",
                    color: MyTheme.failure,
                  ),
                );
              } else {
                vm.ignoreUser!(user: user);
              }
            },
            icon: 'icon_ignore.png',
            width: 40,
            height: 40,
            radius: 20,
            gradient: Styles.buildLinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          SizedBox(
            width: DeviceInfo(context).width! * 0.05,
          ),

          /// express interest
          vm.packageExpire != "Expired"
              ? vm.myInterestStateLoading == false
                  ? ContainerWithIcon(
                      onpressed: () {
                        if (!store.state.userVerifyState!.isApprove!) {
                          store.dispatch(
                            ShowMessageAction(
                              msg: "Please verify your account",
                              color: MyTheme.failure,
                            ),
                          );
                        } else {
                          (vm.isFullProfileView! &&
                                  (vm.myMembershipType == 'Free'))
                              ? store.dispatch(ShowMessageAction(
                                  msg: "Please update your package."))
                              : vm.expressInterest!(userId: user.userId);
                        }
                      },
                      icon: vm.activeMembers![index].interestStatus ==
                              "received interest"
                          ? 'icon_love_full.png'
                          : 'icon_love.png',
                      width: 40,
                      height: 40,
                      radius: 20,
                      isChecked: vm.activeMembers![index].interestStatus == '1',
                      gradient: Styles.buildLinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight))
                  : MyCircularIndicator(
                      width: 40,
                      height: 40,
                      radius: 20,
                      gradient: Styles.buildLinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight),
                    )
              : ContainerWithIcon(
                  onpressed: () {
                    store.dispatch(
                        ShowMessageAction(msg: "Please update your package."));
                  },
                  icon: 'icon_love.png',
                  width: 40,
                  height: 40,
                  radius: 20,
                  gradient: Styles.buildLinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight)),
          SizedBox(
            width: DeviceInfo(context).width! * 0.05,
          ),

          /// add to shortlist
          vm.shortlistStateLoading == false
              ? ContainerWithIcon(
                  onpressed: () {
                    if (!store.state.userVerifyState!.isApprove!) {
                      store.dispatch(
                        ShowMessageAction(
                          msg: "Please verify your account",
                          color: MyTheme.failure,
                        ),
                      );
                    } else {
                      vm.addShortlist!(user: user.userId);
                    }
                  },
                  icon: 'icon_subscribe.png',
                  width: 40,
                  height: 40,
                  radius: 20,
                  gradient: Styles.buildLinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                )
              : MyCircularIndicator(
                  width: 40,
                  height: 40,
                  radius: 20,
                  gradient: Styles.buildLinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
        ],
      ),
      ContainerWithIcon(
        onpressed: () {
          vm.goToNext!();
        },
        icon: 'icon_right.png',
        width: 40,
        height: 40,
        radius: 20,
        opacity: 0.1,
        color: Colors.white,
      ),
    ]);
  }
}

class HomeViewModel {
  bool? isFullProfileView;
  List? activeMembers;
  var isFetch;
  var packageExpire;
  var myInterestStateLoading;
  var shortlistStateLoading;
  var myMembershipType;
  var isShortListed;
  var isInterested;
  PageController? controller;
  TextEditingController? reportController;
  void Function({dynamic user, dynamic reason})? userReport;
  void Function({dynamic user})? addShortlist;
  void Function({required int userId}) expressInterest;
  void Function({dynamic user})? ignoreUser;
  void Function()? goToNext;
  void Function()? goToPrev;

  HomeViewModel({
    this.packageExpire,
    this.isFetch,
    this.activeMembers,
    this.isFullProfileView,
    this.myInterestStateLoading,
    this.shortlistStateLoading,
    this.userReport,
    this.addShortlist,
    required this.expressInterest,
    this.ignoreUser,
    this.myMembershipType,
    this.isInterested,
    this.isShortListed,
    this.controller,
    this.reportController,
    this.goToNext,
    this.goToPrev,
  });

  static fromStore(Store<AppState> store) {
    return HomeViewModel(
      isFullProfileView:
          settingIsActive("full_profile_show_according_to_membership", "1"),
      activeMembers: store.state.homeState!.homeDataList,
      isFetch: store.state.homeState!.isFetching,
      packageExpire: store
          .state.accountState!.profileData?.currentPackageInfo?.packageExpiry,
      myInterestStateLoading: store.state.myInterestState?.isLoading,
      shortlistStateLoading: store.state.shortlistState?.isLoading,
      myMembershipType: store.state.packageDetailsState!.data?.name,
      controller: store.state.homeState!.controller,
      reportController: store.state.homeState!.reportController,

      /// functions
      userReport: ({dynamic user, dynamic reason}) =>
          store.dispatch(reportMiddleware(userId: user, reason: reason)),

      addShortlist: ({dynamic user}) =>
          store.dispatch(addShortlistMiddleware(userId: user)),
      expressInterest: ({required int userId}) =>
          store.dispatch(expressInterestMiddleware(userId: userId)),

      ignoreUser: ({dynamic user}) => store.dispatch(AddToIgnoreListFromHome(
        user: user,
      )),

      goToNext: () => store.dispatch(GoNextPage()),
      goToPrev: () => store.dispatch(GoPrevPage()),
    );
  }
}
