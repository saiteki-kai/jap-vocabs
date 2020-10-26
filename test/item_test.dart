import 'package:flutter_test/flutter_test.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('copyWith', () {
    final item = Item(
      text: '溶岩',
      meaning: 'lava',
      type: 'word',
      reading: 'ようがん',
      jlpt: 3,
      partOfSpeech: 'sostantivo',
    );
    test('It must be equal', () {
      final copy = item.copyWith();
      expect(copy == item, true);
    });

    test('It must be different', () {
      final copy = item.copyWith(
        id: 'id',
        text: 'text',
        meaning: 'meaning',
        reading: 'reading',
        jlpt: 5,
        favorite: true,
        reviewId1: 'reviewId1',
        reviewId2: 'reviewId2',
        type: 'type',
        partOfSpeech: 'partOfSpeech',
        numberOfStrokes: 0,
        examples: [],
      );

      expect(item.id == copy.id, false, reason: 'id must be different');
      expect(item.text == copy.text, false, reason: 'text must be different');
      expect(item.meaning == copy.meaning, false,
          reason: 'meaning must be different');
      expect(item.reading == copy.reading, false,
          reason: 'reading must be different');
      expect(item.jlpt == copy.jlpt, false, reason: 'jlpt must be different');
      expect(item.favorite == copy.favorite, false,
          reason: 'favorite must be different');
      expect(item.reviewId1 == copy.reviewId1, false,
          reason: 'reviewId1 must be different');
      expect(item.reviewId2 == copy.reviewId2, false,
          reason: 'reviewId2 must be different');
      expect(item.type == copy.type, false, reason: 'type must be different');
      expect(item.partOfSpeech == copy.partOfSpeech, false,
          reason: 'partOfSpeech must be different');
      expect(item.numberOfStrokes == copy.numberOfStrokes, false,
          reason: 'numberOfStrokes must be different');
      expect(item.examples == copy.examples, false,
          reason: 'examples must be different');
    });
  });

  group('nextReview', () {
    final uuid = Uuid();
    final itemId = uuid.v1();
    final reviewId1 = uuid.v1();
    final reviewId2 = uuid.v1();

    final date1 = DateTime.now();
    final date2 = DateTime.now().add(Duration(days: 6));

    var review1 = Review(
      id: reviewId1,
      itemId: itemId,
      reviewType: 'meaning',
      type: 'word',
    );

    var review2 = Review(
      id: reviewId2,
      itemId: itemId,
      reviewType: 'meaning',
      type: 'word',
    );

    final item = Item(
      id: itemId,
      reviewId1: reviewId1,
      reviewId2: reviewId2,
      text: '専門家',
      reading: 'せんもんか',
      meaning: 'esperto, specialista, professionista',
      type: 'word',
      partOfSpeech: 'sostantivo',
      jlpt: 2,
    );

    test('Review 1 must be the next one', () {
      final r1 = review1.copyWith(next: date1);
      final r2 = review2.copyWith(next: date2);

      item.review1 = r1;
      item.review2 = r2;

      expect(item.nextReview == r1.next, true);
    });

    test('Review 2 must be the next one', () {
      final r1 = review1.copyWith(next: date2);
      final r2 = review2.copyWith(next: date1);

      item.review1 = r1;
      item.review2 = r2;

      expect(item.nextReview == r2.next, true);
    });

    test('Review 1 must be the next one', () {
      final r1 = review1.copyWith(next: date1);
      final r2 = review2.copyWith(next: null);

      item.review1 = r1;
      item.review2 = r2;

      expect(item.nextReview == r1.next, true);
    });

    test('Review 2 must be the next one', () {
      final r1 = review1.copyWith(next: null);
      final r2 = review2.copyWith(next: date1);

      item.review1 = r1;
      item.review2 = r2;

      expect(item.nextReview == r2.next, true);
    });
  });
}
