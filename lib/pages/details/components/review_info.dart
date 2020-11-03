import 'package:flutter/material.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/utils/date.dart';
import 'package:jap_vocab/utils/progress_color.dart';
import 'package:jap_vocab/utils/review_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReviewInfo extends StatelessWidget {
  final Review review;
  const ReviewInfo({this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              reviewType(context, review.reviewType).toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stat(
                title: S.of(context).details_reviews_ef,
                value: review.ef.toStringAsPrecision(3),
              ),
              Stat(
                title: S.of(context).item_streak,
                value: review.streak.toString(),
              ),
              Stat(
                title: S.of(context).item_correct,
                value: review.timesCorrect.toString(),
              ),
              Stat(
                title: S.of(context).item_incorrect,
                value: review.timesIncorrect.toString(),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stat(
                title: S.of(context).item_nextreview,
                value: Date.format(review.next, full: true) ?? '-',
              ),
              CircularPercentIndicator(
                radius: 64,
                lineWidth: 64 / 6,
                circularStrokeCap: CircularStrokeCap.butt,
                center: Text(
                  '${(review.accuracy * 100).round()}%',
                  textAlign: TextAlign.center,
                ),
                percent: review.accuracy,
                progressColor: colorPercent(review.accuracy),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Stat extends StatelessWidget {
  const Stat({Key key, @required this.title, @required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final _title = const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
    final _subtitle = const TextStyle(fontSize: 14.0);

    return Column(
      children: [
        Text(title, style: _title),
        SizedBox(height: 4.0),
        Text(value, style: _subtitle),
      ],
    );
  }
}
