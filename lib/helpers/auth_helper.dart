import 'package:active_matrimonial_flutter_app/helpers/shared_pref.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signin_response.dart';

// class AuthHelper {
//   setAuthData(SignInResponse data) {
//     prefs.setString(Const.accessToken, data.accessToken!);
//     // prefs.setString(Const.userName, data.user!.name!);
//     // prefs.setString(Const.maritalStatus, data.user!.maritalStatusId!.name!);
//     // prefs.setInt(Const.userId, data.user!.id!);
//     // prefs.setString(Const.userHeight, data.user!.height.toString());
//     // prefs.setString(Const.userAge, data.user!.birthday.toString());
//     // prefs.setString(Const.userEmail,
//     // data.user!.email == null ? data.user!.phone! : data.user!.email!);
//     store.dispatch(AuthData(data.user!));
//   }
// }

void setUserData(SignInResponse request) {
  if (request.result == true) {
    SharedPref().isLoggedIn = true;
    SharedPref().accessToken = request.accessToken!;
    SharedPref().userName = request.user!.name!;
    SharedPref().userEmail = request.user!.email!;
  }
}

void clearUserData() {
  SharedPref().clear();
}
