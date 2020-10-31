import 'package:flutter_test/flutter_test.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:sembast/timestamp.dart';

void main() {
  group('accuracy', () {
    test('It must be 0.5', () {
      final r = Review(timesCorrect: 5, timesIncorrect: 5);
      expect(r.accuracy, 0.5);
    });

    test('It must be 0', () {
      final r1 = Review(timesCorrect: 0, timesIncorrect: 5);
      final r2 = Review(timesCorrect: 0, timesIncorrect: 0);
      expect(r1.accuracy, 0.0);
      expect(r2.accuracy, 0.0);
    });

    test('It must be 1', () {
      final r = Review(timesCorrect: 5, timesIncorrect: 0);
      expect(r.accuracy, 1.0);
    });
  });

  test('toMap', () {
    final r = Review(last: DateTime.now(), next: null);

    expect(
      r.toMap()['last'],
      isInstanceOf<Timestamp>(),
      reason: 'It must be a Timestamp',
    );
    expect(r.toMap()['next'], null);
  });

  group('fromMap', () {
    test('Timestamp argument', () {
      final map1 = {'last': null, 'next': Timestamp.now()};
      final r1 = Review.fromMap(map1);

      expect(
        r1.next,
        isInstanceOf<DateTime>(),
        reason: 'It must be a DateTime',
      );
      expect(r1.last, null);
    });

    test('Other types argument', () {
      final map2 = {'last': 'test', 'next': DateTime.now()};
      final r2 = Review.fromMap(map2);

      expect(r2.last, null);
      expect(r2.next, null);
    });
  });

  group('copyWith', () {
    final review = Review(
      id: '2345u334udfsnfb347',
      ef: 2.6,
      interval: 6,
      reviewType: 'meaning',
      streak: 2,
      timesCorrect: 2,
      timesIncorrect: 0,
      type: 'word',
      last: DateTime.now(),
      next: DateTime.now().add(Duration(days: 6)),
    );

    test('It must be equal', () {
      final copy = review.copyWith();
      expect(copy == review, true);
    });

    test('It must be different', () {
      final copy = review.copyWith(
        id: 'id',
        ef: 1.3,
        interval: 0,
        last: DateTime.now(),
        next: DateTime.now(),
        reviewType: 'reading',
        type: 'kanji',
        streak: 10,
        timesCorrect: 4,
        timesIncorrect: 5,
        itemId: 'itemId',
      );

      expect(
        review.id == copy.id,
        false,
        reason: 'id must be different',
      );
      expect(
        review.ef == copy.ef,
        false,
        reason: 'ef must be different',
      );
      expect(
        review.interval == copy.interval,
        false,
        reason: 'interval must be different',
      );
      expect(
        review.last == copy.last,
        false,
        reason: 'last must be different',
      );
      expect(
        review.next == copy.next,
        false,
        reason: 'next must be different',
      );
      expect(
        review.reviewType == copy.reviewType,
        false,
        reason: 'reviewType must be different',
      );
      expect(
        review.type == copy.type,
        false,
        reason: 'type must be different',
      );
      expect(
        review.streak == copy.streak,
        false,
        reason: 'streak must be different',
      );
      expect(
        review.type == copy.type,
        false,
        reason: 'type must be different',
      );
      expect(
        review.timesCorrect == copy.timesCorrect,
        false,
        reason: 'timesCorrect must be different',
      );
      expect(
        review.timesIncorrect == copy.timesIncorrect,
        false,
        reason: 'timesIncorrect must be different',
      );
      expect(
        review.itemId == copy.itemId,
        false,
        reason: 'itemId must be different',
      );

      expect(copy == review, false, reason: 'The copy must be not equal');
    });
  });
}
