import 'package:flutter_test/flutter_test.dart';
import 'package:jap_vocab/models/review.dart';

void main() {
  group('copyWith', () {
    final review = Review(
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

      expect(review.id == copy.id, false, reason: 'id must be different');
      expect(review.ef == copy.ef, false, reason: 'ef must be different');
      expect(review.interval == copy.interval, false,
          reason: 'interval must be different');
      expect(review.last == copy.last, false, reason: 'last must be different');
      expect(review.next == copy.next, false, reason: 'next must be different');
      expect(review.reviewType == copy.reviewType, false,
          reason: 'reviewType must be different');
      expect(review.type == copy.type, false, reason: 'type must be different');
      expect(review.streak == copy.streak, false,
          reason: 'streak must be different');
      expect(review.type == copy.type, false, reason: 'type must be different');
      expect(review.timesCorrect == copy.timesCorrect, false,
          reason: 'timesCorrect must be different');
      expect(review.timesIncorrect == copy.timesIncorrect, false,
          reason: 'timesIncorrect must be different');
      expect(review.itemId == copy.itemId, false,
          reason: 'itemId must be different');

      expect(copy == review, false, reason: 'The copy must be not equal');
    });
  });
}
