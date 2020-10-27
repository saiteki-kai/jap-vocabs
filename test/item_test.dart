import 'package:flutter_test/flutter_test.dart';
import 'package:jap_vocab/models/example.dart';
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

      expect(copy == item, false, reason: 'The copy must be not equal');
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

  group('toMap', () {
    final item = Item(
      text: '溶岩',
      meaning: 'lava',
      type: 'word',
      reading: 'ようがん',
      jlpt: 3,
      partOfSpeech: 'sostantivo',
    );

    test('example', () {
      final item1 = item.toMap();
      final item2 = item.copyWith(examples: []).toMap();
      final item3 = item.copyWith(examples: [Example(), Example()]).toMap();

      expect(item1['examples'], []);
      expect(item2['examples'], isInstanceOf<List<Map<String, dynamic>>>());
      expect(item3['examples'], isInstanceOf<List<Map<String, dynamic>>>());
    });

    test('empty fields', () {
      final item1 = Item(
        text: '水',
        meaning: 'acqua',
        type: 'word',
      ).toMap();

      final item2 = Item(
        text: '水',
        meaning: 'acqua',
        type: 'word',
        reading: 'mizu',
        favorite: true,
        partOfSpeech: 'sostantivo',
        jlpt: 3,
        numberOfStrokes: 12,
      ).toMap();

      final fieldsToCheck = [
        'reading',
        'part_of_speech',
        'favorite',
        'jlpt',
        'number_of_strokes',
      ];

      for (var i = 0; i < fieldsToCheck.length; i++) {
        expect(
          item1.containsKey(fieldsToCheck[i]),
          false,
          reason: 'Field \'${fieldsToCheck[i]}\' must be absent',
        );
        expect(
          item2.containsKey(fieldsToCheck[i]),
          true,
          reason: 'Field \'${fieldsToCheck[i]}\' must be present',
        );
      }
    });
  });

  group('fromMap', () {
    test('examples argument', () {
      final item1 = Item.fromMap({
        'examples': null,
      });
      final item2 = Item.fromMap({
        'examples': <Map<String, dynamic>>[],
      });
      final item3 = Item.fromMap({
        'examples': <Map<String, dynamic>>[{}],
      });

      expect(
        item1.examples,
        [],
        reason: 'It must be an empty list',
      );

      expect(
        item2.examples,
        isInstanceOf<List<Example>>(),
        reason: 'It must be an instance of List<Example>',
      );

      expect(
        item3.examples,
        isInstanceOf<List<Example>>(),
        reason: 'It must be an instance of List<Example>',
      );
    });
  });
}
