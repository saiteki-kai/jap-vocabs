import 'package:jap_vocab/redux/actions/settings_actions.dart';
import 'package:jap_vocab/redux/state/settings_state.dart';
import 'package:redux/redux.dart';

Reducer<SettingsState> settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState, ChangeLayoutAction>(_changeLayout),
  TypedReducer<SettingsState, ChangeTimeAction>(_changeReviewTime),
  TypedReducer<SettingsState, ChangeDayAction>(_changeReviewDay),
  TypedReducer<SettingsState, EnableRemainderAction>(_enableReviewRemainder),
  TypedReducer<SettingsState, SetLocaleAction>(_setLocale),
]);

SettingsState _changeLayout(SettingsState state, ChangeLayoutAction action) {
  return state.copyWith(altLayout: action.value);
}

SettingsState _changeReviewTime(SettingsState state, ChangeTimeAction action) {
  return state.copyWith(review: state.review.copyWith(time: action.time));
}

SettingsState _changeReviewDay(SettingsState state, ChangeDayAction action) {
  return state.copyWith(review: state.review.copyWith(days: action.days));
}

SettingsState _enableReviewRemainder(
    SettingsState state, EnableRemainderAction action) {
  return state.copyWith(review: state.review.copyWith(enabled: action.value));
}

SettingsState _setLocale(SettingsState state, SetLocaleAction action) {
  return state.copyWith(languageCode: action.languageCode);
}
