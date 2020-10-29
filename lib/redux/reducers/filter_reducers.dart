import 'package:jap_vocab/redux/actions/filter_actions.dart';
import 'package:jap_vocab/redux/state/filter_state.dart';
import 'package:redux/redux.dart';

Reducer<FilterState> filterReducer = combineReducers<FilterState>([
  TypedReducer<FilterState, ChangeSearchAction>(_changeSearch),
  TypedReducer<FilterState, ChangeTypeAction>(_changeType),
  TypedReducer<FilterState, ChangeJLTPAction>(_changeJLPT),
  TypedReducer<FilterState, ChangeLevelAction>(_changeLevel),
  TypedReducer<FilterState, ChangePartOfSpeechAction>(_changePartOfSpeech),
]);

FilterState _changeSearch(FilterState state, ChangeSearchAction action) {
  return state.copyWith(search: action.search);
}

FilterState _changeType(FilterState state, ChangeTypeAction action) {
  return state.copyWith(type: action.type);
}

FilterState _changeJLPT(FilterState state, ChangeJLTPAction action) {
  return state.copyWith(type: action.jlpt);
}

FilterState _changeLevel(FilterState state, ChangeLevelAction action) {
  return state.copyWith(type: action.level);
}

FilterState _changePartOfSpeech(
  FilterState state,
  ChangePartOfSpeechAction action,
) {
  return state.copyWith(type: action.partOfSpeech);
}
