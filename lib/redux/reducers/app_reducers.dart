import 'package:jap_vocab/redux/reducers/filter_reducers.dart';
import 'package:jap_vocab/redux/reducers/item_reducers.dart';
import 'package:jap_vocab/redux/reducers/reviews_reducers.dart';
import 'package:jap_vocab/redux/reducers/settings_reducers.dart';
import 'package:jap_vocab/redux/state/app_state.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    filterState: filterReducer(state.filterState, action),
    itemsState: itemsReducer(state.itemsState, action),
    reviewsState: reviewsReducer(state.reviewsState, action),
    settingsState: settingsReducer(state.settingsState, action),
  );
}