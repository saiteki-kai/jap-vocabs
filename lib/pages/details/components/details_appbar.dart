import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/pages/details/components/confirm_dialog.dart';
import 'package:jap_vocab/pages/details/components/md2_indicator.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';
import 'package:redux/redux.dart';

class DetailsAppBar extends StatelessWidget {
  final Item item;
  final List<String> tabs;
  final Function(int) onTabChange;
  final TabController controller;

  DetailsAppBar({
    Key key,
    this.item,
    this.tabs,
    this.onTabChange,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => store,
      builder: (context, Store<AppState> store) {
        return AppBar(
          title: Text(
            item.text,
            overflow: TextOverflow.ellipsis,
          ),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                item.favorite ? Icons.favorite : Icons.favorite_border,
                color: item.favorite ? Colors.white : null,
              ),
              tooltip: 'Favorite',
              onPressed: () async {
                await store.dispatch(toggleFavoriteItem(item));
              },
            ),
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: 'Edit',
              onPressed: () {
                Navigator.pushNamed(context, '/edit',
                    arguments: {'item': item});
              },
            ),
            IconButton(
              icon: Icon(Icons.restore),
              tooltip: 'Reset',
              onPressed: () {
                showConfirmDialog(
                  context,
                  message: 'Reset reviews progress for this item?',
                  buttonText: 'Reset',
                  onConfirm: () async {
                    await store.dispatch(resetItem(item));
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: 'Delete',
              onPressed: () {
                showConfirmDialog(
                  context,
                  message: 'Delete this item?',
                  buttonText: 'Delete',
                  onConfirm: () async {
                    await store.dispatch(deleteItem(item));
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
          bottom: TabBar(
            controller: controller,
            unselectedLabelColor: Colors.white30,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: MD2Indicator(
              indicatorHeight: 4.0,
              indicatorColor: Colors.white,
              horizontalPadding: 16.0,
            ),
            onTap: onTabChange,
            tabs: tabs.map((t) => Tab(text: t)).toList(),
          ),
        );
      },
    );
  }
}
