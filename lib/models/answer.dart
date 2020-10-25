import 'package:flutter/material.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/models/review.dart';

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
