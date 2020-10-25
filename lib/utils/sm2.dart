// https://www.supermemo.com/en/archives1990-2015/english/ol/sm2
//
// Quality:
// 5 - perfect response
// 4 - correct response after a hesitation
// 3 - correct response recalled with serious difficulty
// 2 - incorrect response; where the correct one seemed easy to recall
// 1 - incorrect response; the correct one remembered
// 0 - complete blackout.

import 'package:jap_vocab/data/review.dart';

class SM2 {
  static Review newIteration(Review r, int q) {
    var streak = r.streak;
    var correct = r.timesCorrect;
    var incorrect = r.timesIncorrect;
    var ef = r.ef;
    var interval = 1;

    if (q < 3) {
      streak = 0;
      incorrect++;
      // interval = 1;
      // ef = r.ef;
    } else {
      ef = r.ef - 0.8 + 0.28 * q - 0.02 * q * q;

      if (r.streak == 0) {
        interval = 1;
      } else if (r.streak == 1) {
        interval = 6;
      } else {
        interval = (r.interval * ef).round();
      }

      streak++;
      correct++;
    }

    if (ef < 1.3) ef = 1.3;

    final last = DateTime.now();
    final next = DateTime.now().add(Duration(days: interval));

    return r.copyWith(
      ef: ef,
      interval: interval,
      streak: streak,
      last: last,
      next: next,
      timesCorrect: correct,
      timesIncorrect: incorrect,
    );
  }
}
