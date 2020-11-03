import 'package:flutter/material.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/answer.dart';
import 'package:jap_vocab/utils/date.dart';
import 'package:jap_vocab/utils/review_utils.dart';

class ListItem extends StatelessWidget {
  final Answer answer;

  const ListItem({Key key, @required this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                answer.item.text,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                Date.format(answer.review.next) ?? '-',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                answer.correct
                    ? S.of(context).item_correct
                    : S.of(context).item_incorrect,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: answer.correct ? Colors.green : Colors.redAccent,
                    ),
              ),
              SizedBox(height: 4.0),
              Text(
                reviewType(context, answer.review.reviewType).toUpperCase(),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
