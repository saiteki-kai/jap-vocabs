import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/utils/sm2.dart';

void main() {
  group('SM2 Algorithm', () {
    test('Iteration example check', () {
      final r0 = Review();
      expect(r0.streak, 0);

      final r1 = SM2.newIteration(r0, 5);
      expect(r1.streak, 1);
      expect(r1.interval, 1);

      final r2 = SM2.newIteration(r1, 4);
      expect(r2.streak, 2);
      expect(r2.interval, 6);
      expect(r2.ef, r1.ef);

      expect(r1.next == r2.next, false);
    });

    test('NextDate check', () {
      final r0 = Review();

      final r1 = SM2.newIteration(r0, 5);
      final r2 = SM2.newIteration(r1, 0);
      final r3 = SM2.newIteration(r2, 3);
      final r4 = SM2.newIteration(r3, 4);
      final r5 = SM2.newIteration(r4, 5);
      final r6 = SM2.newIteration(r5, 5);

      expect(r2.streak, 0);
      expect(r2.interval, 1);

      expect(r1.next.difference(r2.next).inMinutes == 0, true);
      expect(r2.next.difference(r3.next).inMinutes == 0, true);
      expect(r3.next.difference(r4.next).inMinutes == 0, false);
      expect(r4.next.difference(r5.next).inMinutes == 0, false);
      expect(r5.next.difference(r6.next).inMinutes == 0, false);
    });

    test('Streak check', () {
      var oldR = Review();
      for (var i = 0; i < 100; i++) {
        final q = Random().nextInt(6);
        var newR = SM2.newIteration(oldR, q);

        if (q == 4) {
          expect(newR.ef.toStringAsPrecision(2), oldR.ef.toStringAsPrecision(2));
        }

        if (q < 3) {
          expect(newR.ef.toStringAsPrecision(2), oldR.ef.toStringAsPrecision(2));
          expect(newR.streak, 0);
        }

        //print('$q -> $oldR');
        //print("${oldR.ef}, ${oldR.last}");

        oldR = newR;
      }
    });
  });
}
