import 'dart:async';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/database/app_database.dart';
import 'package:jap_vocab/database/review_dao.dart';
import 'package:jap_vocab/redux/state/filter_state.dart';
import 'package:jap_vocab/redux/state/order_state.dart';
import 'package:sembast/sembast.dart';

class ItemDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  final _store = intMapStoreFactory.store('items');

  Future<Item> getItemById(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final snapshot = await _store.findFirst(await _db, finder: finder);

    if (snapshot != null) {
      return Item.fromMap(snapshot.value);
    }
    return null;
  }

  Future insertItem(Item item) async {
    await _store.add(await _db, item.toMap());
  }

  Future updateItem(Item item) async {
    final finder = Finder(filter: Filter.equals('id', item.id));
    await _store.update(await _db, item.toMap(), finder: finder);
  }

  Future delete(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    await _store.delete(await _db, finder: finder);
  }

  Future<List<Item>> getAllItems({FilterState filter, OrderState order}) async {
    var filters = [Filter.equals('type', filter.type)];

    if (filter.search != null && filter.search.isNotEmpty) {
      filters.add(
        Filter.or(
          [
            Filter.matches('text', filter.search),
            Filter.matches('reading', filter.search),
          ],
        ),
      );
    }

    if (filter.jlpt != null && filter.jlpt.isNotEmpty) {
      filters.add(Filter.inList('jlpt', filter.jlpt));
    }

    if (filter.type == 'word' &&
        filter.partOfSpeech != null &&
        filter.partOfSpeech.isNotEmpty) {
      filters.add(Filter.custom((record) {
        for (var i = 0; i < filter.partOfSpeech.length; i++) {
          if (record.value['part_of_speech'].contains(filter.partOfSpeech[i])) {
            return true;
          }
        }
        return false;
      }));
    }

    final recordSnapshot = await _store.find(
      await _db,
      finder: Finder(filter: Filter.and(filters)),
    );

    if (recordSnapshot != null) {
      final futureList = recordSnapshot.map((snapshot) async {
        final item = Item.fromMap(snapshot.value);
        item.review1 = await ReviewDao().getReviewById(item.reviewId1);
        item.review2 = await ReviewDao().getReviewById(item.reviewId2);

        return item;
      }).toList();

      var list = await Future.wait(futureList);

      if (list == null || list.isEmpty) return [];

      if (filter.level != null && filter.level.isNotEmpty) {
        list = list.where((Item item) {
          if (item.streak >= 6.0 && filter.level.contains('strong')) {
            return true;
          } else if (item.streak >= 4.0 && filter.level.contains('medium')) {
            return true;
          } else {
            return filter.level.contains('weak');
          }
        }).toList();
      }

      return list..sort(Item.comparator(order.field, order.mode));
    }
    return null;
  }
}
