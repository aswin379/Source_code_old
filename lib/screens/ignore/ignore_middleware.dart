import 'package:active_matrimonial_flutter_app/redux/app/app_state.dart';
import 'package:active_matrimonial_flutter_app/repository/ignore_repository.dart';
import 'package:active_matrimonial_flutter_app/screens/ignore/ignore_action.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../const/my_theme.dart';
import '../../redux/libs/helpers/show_message_state.dart';

ThunkAction<AppState> ignoreMiddleware() {
  return (Store<AppState> store) async {
    var page = store.state.ignoreState!.page;

    try {
      var data = await IgnoreRepository().fetchIgnoreList(page: page);
      store.dispatch(IgnoreStoreAction(payload: data));
    } catch (e) {
      store.dispatch(IgnoreFailureAction(error: e.toString()));
      //debugPrint(e.toString());
      return;
    }
  };
}

ThunkAction<AppState> removeIgnoreMiddleware({dynamic user}) {
  return (Store<AppState> store) async {
    try {
      var data = await IgnoreRepository().removeFromIgnore(user: user);

      store.dispatch(ShowMessageAction(
          msg: data.message,
          color: data.result == true ? MyTheme.success : MyTheme.failure));
    } catch (e) {
      //debugPrint(e);
      return;
    }
  };
}
