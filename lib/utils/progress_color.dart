import 'package:flutter/material.dart';

Color colorPercent(double perc) {
  if (perc < 0.3) return Colors.redAccent;
  if (perc < 0.6) return Colors.amberAccent;
  return Colors.green;
}
