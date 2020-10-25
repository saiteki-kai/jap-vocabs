import 'package:flutter/cupertino.dart';
import 'package:jap_vocab/data/item.dart';
import 'package:jap_vocab/data/review.dart';

class Answer {
  final Item item;
  final Review review;
  final bool correct;

  const Answer({
    @required this.item,
    @required this.review,
    @required this.correct,
  });
}
