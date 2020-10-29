import 'package:jap_vocab/redux/actions/order_actions.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> changeSortField(String field) {
  return (Store<AppState> store) async {
    if (field != null && field.isNotEmpty) {
      await store.dispatch(ChangeSortFieldAction(field));
      await store.dispatch(getItems());
    }
  };
}

ThunkAction<AppState> changeSortMode(String mode) {
  return (Store<AppState> store) async {
    if (mode != null && mode.isNotEmpty) {
      await store.dispatch(ChangeSortModeAction(mode));
      await store.dispatch(getItems());
    }
  };
}
