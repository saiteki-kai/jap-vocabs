import 'package:jap_vocab/redux/actions/filter_actions.dart';
import 'package:jap_vocab/redux/state/filter_state.dart';
import 'package:redux/redux.dart';

Reducer<FilterState> filterReducer = combineReducers<FilterState>([
  TypedReducer<FilterState, ChangeSearchAction>(_changeSearch),
  TypedReducer<FilterState, ChangeTypeAction>(_changeType),
]);

FilterState _changeSearch(FilterState state, ChangeSearchAction action) {
  return state.copyWith(search: action.search);
}

FilterState _changeType(FilterState state, ChangeTypeAction action) {
  return state.copyWith(type: action.type);
}
