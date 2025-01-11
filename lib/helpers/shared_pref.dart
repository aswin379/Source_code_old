import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._internal();
  SharedPreferences? _prefs;

  SharedPref._internal();

  factory SharedPref() {
    return _instance;
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _checkAndClearInvalidData();
  }

  getInstance() {
    _prefs ??= SharedPref() as SharedPreferences?;
    return _prefs;
  }

  void _checkAndClearInvalidData() {
    if (_prefs != null) {
      if (_prefs!.get('isLoggedIn') is! bool) {
        _prefs!.remove('isLoggedIn');
      }
    }
  }

  /// is logged in
  bool get isLoggedIn => _prefs?.getBool('isLoggedIn') ?? false;

  set isLoggedIn(bool value) {
    _prefs?.setBool('isLoggedIn', value);
  }

  /// is view
  bool get isView => _prefs?.getBool('isView') ?? false;

  set isView(bool value) {
    _prefs?.setBool('isView', value);
  }

  /// showDialog
  bool get showDialog => _prefs?.getBool('showDialog') ?? false;

  set showDialog(bool value) {
    _prefs?.setBool('showDialog', value);
  }

  /// deactivate
  bool get deactivate => _prefs?.getBool('deactivate') ?? false;

  set deactivate(bool value) {
    _prefs?.setBool('deactivate', value);
  }

  /// user access token
  String get accessToken => _prefs?.getString('accessToken') ?? '';

  set accessToken(String value) {
    _prefs?.setString('accessToken', value);
  }

  /// user name
  String get userName => _prefs?.getString('userName') ?? '';

  set userName(String value) {
    _prefs?.setString('userName', value);
  }

  /// resetVerificationCode
  String get resetVerificationCode =>
      _prefs?.getString('resetVerificationCode') ?? '';

  set resetVerificationCode(String value) {
    _prefs?.setString('resetVerificationCode', value);
  }

  /// resetSendBy
  String get resetSendBy => _prefs?.getString('resetSendBy') ?? '';

  set resetSendBy(String value) {
    _prefs?.setString('resetSendBy', value);
  }

  /// resetEmail
  String get resetEmail => _prefs?.getString('resetEmail') ?? '';

  set resetEmail(String value) {
    _prefs?.setString('resetEmail', value);
  }

  /// user email
  String get userEmail => _prefs?.getString('userEmail') ?? '';

  set userEmail(String value) {
    _prefs?.setString('userEmail', value);
  }

  void clear() {
    _prefs?.clear();
  }
}
