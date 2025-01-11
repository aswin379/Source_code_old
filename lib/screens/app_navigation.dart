import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/helpers/connectivity_helper.dart';
import 'package:active_matrimonial_flutter_app/helpers/get_context.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/common/common_states_middleware.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/drop_down/profile_dropdown_middleware.dart';
import 'package:active_matrimonial_flutter_app/screens/account/account.dart';
import 'package:active_matrimonial_flutter_app/screens/auth/signin/signin.dart';
import 'package:active_matrimonial_flutter_app/screens/chat/chat_list.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/explore/explore.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/home/home.dart';
import 'package:active_matrimonial_flutter_app/screens/home_pages/home_without_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../helpers/push_notification_service.dart';
import '../helpers/shared_pref.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemHelper.context = context;

    // Initialize network connectivity and middleware
    _initializeApp();

    // Initialize push notifications
    Future.delayed(const Duration(milliseconds: 1), () async {
      await PushNotificationService().initNotifications();
    });
  }

  void _initializeApp() {
    ConnectivityHelper().abortIfNotConnected(context, _onConnectivityChange);

    // Dispatch Redux actions if needed
    final profileDropdownData =
        store.state.manageProfileCombineState?.profiledropdownResponseData;
    if (profileDropdownData?.result != true) {
      store.dispatch(profiledropdownMiddleware());
    }

    if (store.state.commonState?.countries?.isEmpty ?? true) {
      store.dispatch(commonStateCountryMiddleware());
    }

    // // Check login state
    // _isLoggedIn = store.state.authState?.userData != null;
  }

  void _onConnectivityChange(value) {
    ConnectivityHelper().abortIfNotConnected(context, _onConnectivityChange);
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: SizedBox(
          height: 75,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: MyTheme.zircon,
            selectedItemColor: MyTheme.app_accent_color,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: MyTheme.storm_grey,
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            onTap: onTapped,
            items: [
              _buildBottomNavigationBarItem(
                icon: 'assets/icon/icon_members.png',
                label: AppLocalizations.of(context)!.common_active_members,
              ),
              _buildBottomNavigationBarItem(
                icon: 'assets/icon/icon_explore.png',
                label: AppLocalizations.of(context)!.common_active_explore,
              ),
              _buildBottomNavigationBarItem(
                icon: 'assets/icon/icon_chat.png',
                label: AppLocalizations.of(context)!.common_active_chat,
              ),
              _buildBottomNavigationBarItem(
                icon: 'assets/icon/icon_account.png',
                label: AppLocalizations.of(context)!.common_active_account,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }
    return true;
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return SharedPref().isLoggedIn ? const Home() : const HomeWithoutLogin();
    } else if (_currentIndex == 1) {
      return const Explore();
    } else if (_currentIndex == 2) {
      return SharedPref().isLoggedIn
          ? ChatList(backButtonAppearance: false)
          : Login();
    } else if (_currentIndex == 3) {
      return SharedPref().isLoggedIn ? const Account() : Login();
    }
    return const SizedBox.shrink();
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageIcon(
          AssetImage(icon),
          size: 18.0,
        ),
      ),
      label: label,
    );
  }
}
