import 'package:flutter_test/flutter_test.dart';
import 'package:jap_vocab/utils/date.dart';

void main() {
  group('format', () {
    final now = DateTime.now();

    test('today', () {
      final date = DateTime(now.year, now.month, now.day, 7);

      expect(
        Date.format(now),
        '今',
        reason: 'It must be now',
      );

      expect(
        Date.format(date.add(Duration(hours: 15))),
        '22時00分',
        reason: 'It must be 22 o\'clock',
      );
    });

    test('tomorrow', () {
      expect(
        Date.format(now.add(Duration(days: 1, minutes: 30))),
        '明日',
        reason: 'It must be tomorrow',
      );
    });

    test('in-week days', () {
      for (var d = 2; d < 7; d++) {
        expect(
          Date.format(now.add(Duration(days: d, minutes: 30))),
          '${d}日',
          reason: 'It must be $d day${d > 1 ? "s" : ""}',
        );
      }
    });

    test('in-month weeks', () {
      for (var w = 1; w < 4; w++) {
        expect(
          Date.format(now.add(Duration(days: w * 7, minutes: 30))),
          '${w}週',
          reason: 'It must be $w week${w > 1 ? "s" : ""}',
        );
      }
    });

    test('in-year months', () {
      for (var m = 1; m < 12; m++) {
        expect(
          Date.format(now.add(Duration(days: m * 30, minutes: 30))),
          '${m}月',
          reason: 'It must be $m month${m > 1 ? "s" : ""}',
        );
      }
    });

    test('years', () {
      expect(
        Date.format(now.add(Duration(days: 365, minutes: 30))),
        '1年',
        reason: 'It must be 1 year',
      );
      expect(
        Date.format(now.add(Duration(days: 365 * 2, minutes: 30))),
        '2年',
        reason: 'It must be 2 years',
      );
    });
  });
}
