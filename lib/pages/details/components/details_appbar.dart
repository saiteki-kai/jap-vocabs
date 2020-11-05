import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/pages/details/components/confirm_dialog.dart';
import 'package:jap_vocab/components/md2_indicator.dart';
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
      distinct: true,
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
              tooltip: S.of(context).tooltip_favorite,
              onPressed: () async {
                await store.dispatch(toggleFavoriteItem(item));
              },
            ),
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: S.of(context).tooltip_edit,
              onPressed: () {
                Navigator.pushNamed(context, '/edit',
                    arguments: {'item': item});
              },
            ),
            IconButton(
              icon: Icon(Icons.restore),
              tooltip: S.of(context).tooltip_reset,
              onPressed: () {
                showConfirmDialog(
                  context,
                  message: S.of(context).dialog_reset_msg,
                  buttonText: S.of(context).button_reset,
                  onConfirm: () async {
                    await store.dispatch(resetItem(item));
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: S.of(context).tooltip_delete,
              onPressed: () {
                showConfirmDialog(
                  context,
                  message: S.of(context).dialog_delete_msg,
                  buttonText: S.of(context).button_delete,
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
