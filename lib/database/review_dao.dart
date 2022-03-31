import 'dart:math';

import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/database/app_database.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

enum ReviewsFilter { ALL, NEXT, NOW }

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

  Future<List<Review>> getAllReviews({filter = ReviewsFilter.NEXT}) async {
    var finder;

    if (filter == ReviewsFilter.NOW) {
      finder = Finder(
        filter: Filter.or(
          [
            Filter.equals('next', null),
            Filter.lessThan('next', Timestamp.now()),
          ],
        ),
      );
    }

    final recordSnapshot = await _store.find(await _db, finder: finder);

    List<Review> reviews;

    if (recordSnapshot != null) {
      reviews = recordSnapshot.map((snapshot) {
        return Review.fromMap(snapshot.value);
      }).toList();
    }

    if (filter == ReviewsFilter.NEXT && reviews.isNotEmpty) {
      var timestamps = reviews
          .map((e) => e.next?.millisecondsSinceEpoch ?? 8640000000000000000)
          .toList();
      var last = timestamps.reduce(min);

      reviews = reviews.where((r) {
        if (r.next == null) return false;
        final millis = DateTime.now().millisecondsSinceEpoch;

        return r.next.millisecondsSinceEpoch == last ||
            r.next.millisecondsSinceEpoch <= millis;
      }).toList();
    }

    print(reviews);

    return reviews;
  }
}
