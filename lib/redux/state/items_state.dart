import 'package:flutter/foundation.dart';
import 'package:jap_vocab/data/item.dart';

@immutable
class ItemsState {
  final List<Item> items;
  final Item item;
  const ItemsState({@required this.items, this.item});

  ItemsState.initial()
      : items = List.unmodifiable(<Item>[]),
        item = null;

  ItemsState copyWith({List<Item> items, Item item}) {
    return ItemsState(
      items: items ?? this.items,
      item: item ?? this.item,
    );
  }
}
