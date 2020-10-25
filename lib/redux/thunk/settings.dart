import 'package:jap_vocab/redux/actions/settings_actions.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> changeLayoutAction(bool value) {
  return (Store<AppState> store) async {
    // await store.writeOnDisk();
    await store.dispatch(ChangeLayoutAction(value));
  };
}

ThunkAction<AppState> setBackupPathAction(String path) {
  return (Store<AppState> store) async {
    // await store.writeOnDisk();
    await store.dispatch(SetBackupPathAction(path));
  };
}
