import 'package:jap_vocab/redux/actions/order_actions.dart';
import 'package:jap_vocab/redux/state/order_state.dart';
import 'package:redux/redux.dart';

Reducer<OrderState> orderReducer = combineReducers<OrderState>([
  TypedReducer<OrderState, ChangeSortFieldAction>(_changeField),
  TypedReducer<OrderState, ChangeSortModeAction>(_changeMode),
]);

OrderState _changeField(OrderState state, ChangeSortFieldAction action) {
  return state.copyWith(field: action.field);
}

OrderState _changeMode(OrderState state, ChangeSortModeAction action) {
  return state.copyWith(mode: action.mode);
}
