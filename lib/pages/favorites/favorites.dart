import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/pages/home/components/list_item.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';
import 'package:redux/redux.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      onInitialBuild: (_ViewModel vm) => vm.getFavorites(),
      builder: (context, _ViewModel vm) {
        return CustomLayout(
          appBar: AppBar(
            title: Text(S.of(context).title_favorites),
            titleSpacing: 0.0,
          ),
          body: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: vm.favorites?.length ?? 0,
            itemBuilder: (context, index) {
              return ListItem(item: vm.favorites[index]);
            },
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List<Item> favorites;
  final Function getFavorites;

  _ViewModel({this.favorites, this.getFavorites});

  factory _ViewModel.create(Store<AppState> store) {
    final _items = store.state.itemsState.items;

    void _getItems() {
      store.dispatch(getItems());
    }

    return _ViewModel(
      favorites: _items.where((i) => i.favorite).toList(growable: false),
      getFavorites: _getItems,
    );
  }
}
