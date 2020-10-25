import 'package:flutter/foundation.dart';
import 'package:jap_vocab/data/review.dart';
import 'package:jap_vocab/database/app_database.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

class ReviewDao {
  Future<Database> get _db async => await AppDatabase.instance.database;

  final _store = intMapStoreFactory.store('reviews');

  Future<Review> getReviewById(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final snapshot = await _store.findFirst(await _db, finder: finder);

    if (snapshot != null) {
      return Review.fromMap(snapshot.value);
    }
    return null;
  }

  Future insertReview(Review review) async {
    await _store.add(await _db, review.toMap());
  }

  Future updateReview(Review review) async {
    final finder = Finder(filter: Filter.equals('id', review.id));
    await _store.update(await _db, review.toMap(), finder: finder);
  }

  Future delete(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    await _store.delete(await _db, finder: finder);
  }

  Future<List<Review>> getAllReviews({
    bool todo = false,
    @required String type,
  }) async {
    var finder = Finder(filter: Filter.equals('type', type));

    if (todo) {
      finder = Finder(
        filter: Filter.and(
          [
            Filter.equals('type', type),
            Filter.or(
              [
                Filter.equals('next', null),
                Filter.lessThan('next', Timestamp.now()),
              ],
            ),
          ],
        ),
      );
    }

    final recordSnapshot = await _store.find(await _db, finder: finder);

    if (recordSnapshot != null) {
      return recordSnapshot.map((snapshot) {
        return Review.fromMap(snapshot.value);
      }).toList();
    }
    return null;
  }
}
