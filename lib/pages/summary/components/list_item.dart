import 'package:flutter/material.dart';
import 'package:jap_vocab/data/answer.dart';
import 'package:jap_vocab/utils/date.dart';

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
                answer.correct ? '正解' : '不正解',
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: answer.correct ? Colors.green : Colors.redAccent,
                    ),
              ),
              SizedBox(height: 4.0),
              Text(
                answer.review.reviewType.toUpperCase(),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
