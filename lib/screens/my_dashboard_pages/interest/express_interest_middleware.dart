import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/repository/interest_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:active_matrimonial_flutter_app/screens/my_dashboard_pages/interest/my_interest_action.dart';

import '../../../redux/libs/member_info/member_info.dart';
import '../../home_pages/home/home_middleware.dart';

ThunkAction<AppState> expressInterestMiddleware({required int userId}) {
  return (Store<AppState> store) async {
    store.dispatch(ExpressInterestAction());
    try {
      var data = await InterestRepository().express_interest(userId: userId);
      store.dispatch(ExpressInterestAction());

      if (data.result) {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.success));
        // store.dispatch(ShortListReset());
        store.dispatch(homeMiddleware());
        store.dispatch(memberInfoMiddleware(userId: userId));
      } else {
        store.dispatch(
            ShowMessageAction(msg: data.message, color: MyTheme.failure));
      }
    } catch (e) {
      //debugPrint(e.toString());
      return;
    }
  };
}
