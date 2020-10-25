import 'package:jap_vocab/redux/actions/items_actions.dart';
import 'package:jap_vocab/redux/state/items_state.dart';
import 'package:redux/redux.dart';

Reducer<ItemsState> itemsReducer = combineReducers<ItemsState>([
  TypedReducer<ItemsState, LoadedItemsAction>(_loadItemsReducer),
  TypedReducer<ItemsState, LoadedItemAction>(_loadItemReducer),
]);

ItemsState _loadItemsReducer(ItemsState state, LoadedItemsAction action) {
  return state.copyWith(items: action.items);
}

ItemsState _loadItemReducer(ItemsState state, LoadedItemAction action) {
  return state.copyWith(item: action.item);
}
