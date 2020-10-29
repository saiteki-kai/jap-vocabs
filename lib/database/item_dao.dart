import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/database/app_database.dart';
import 'package:jap_vocab/database/review_dao.dart';
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

  Future<List<Item>> getAllItems(
      {@required String type,
      String search,
      String sortField,
      String sortMode}) async {
    var finder = Finder(filter: Filter.equals('type', type));

    if (search != null && search.isNotEmpty) {
      finder = Finder(
        filter: Filter.and(
          [
            Filter.equals('type', type),
            Filter.or(
              [
                Filter.matches('text', search),
                Filter.matches('reading', search)
              ],
            ),
          ],
        ),
      );
    }

    final recordSnapshot = await _store.find(await _db, finder: finder);

    if (recordSnapshot != null) {
      final list = recordSnapshot.map((snapshot) async {
        final item = Item.fromMap(snapshot.value);
        item.review1 = await ReviewDao().getReviewById(item.reviewId1);
        item.review2 = await ReviewDao().getReviewById(item.reviewId2);

        return item;
      }).toList();

      final sorted = await Future.wait(list);
      return sorted..sort(Item.comparator(sortField, sortMode));
    }
    return null;
  }
}
