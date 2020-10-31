import 'package:jap_vocab/utils/date.dart';
import 'package:sembast/timestamp.dart';

class Review {
  final String id;
  final double ef;
  final int interval;
  final int streak;
  final DateTime last;
  final DateTime next;
  final int timesCorrect;
  final int timesIncorrect;
  final String reviewType;
  final String type;
  final String itemId;

  Review({
    this.id,
    this.ef = 2.5,
    this.interval = 0,
    this.streak = 0,
    this.last,
    this.next,
    this.timesCorrect = 0,
    this.timesIncorrect = 0,
    this.reviewType,
    this.type,
    this.itemId,
  });

  double get accuracy {
    final total = timesCorrect + timesIncorrect;
    if (total == 0) return 0;
    return timesCorrect / total;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'EF': ef,
      'interval': interval,
      'streak': streak,
      'last': last != null ? Timestamp.fromDateTime(last) : null,
      'next': next != null ? Timestamp.fromDateTime(next) : null,
      'times_correct': timesCorrect,
      'times_incorrect': timesIncorrect,
      'review_type': reviewType,
      'type': type,
      'itemId': itemId,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      ef: map['EF'],
      interval: map['interval'],
      streak: map['streak'],
      last: map['last'] is Timestamp ? map['last'].toDateTime() : null,
      next: map['next'] is Timestamp ? map['next'].toDateTime() : null,
      timesCorrect: map['times_correct'],
      timesIncorrect: map['times_incorrect'],
      reviewType: map['review_type'],
      type: map['type'],
      itemId: map['itemId'],
    );
  }

  Review copyWith({
    String id,
    double ef,
    int interval,
    int streak,
    DateTime last,
    DateTime next,
    int timesCorrect,
    int timesIncorrect,
    String reviewType,
    String type,
    String itemId,
  }) {
    return Review(
      id: id ?? this.id,
      ef: ef ?? this.ef,
      interval: interval ?? this.interval,
      streak: streak ?? this.streak,
      last: last ?? this.last,
      next: next ?? this.next,
      timesIncorrect: timesIncorrect ?? this.timesIncorrect,
      timesCorrect: timesCorrect ?? this.timesCorrect,
      reviewType: reviewType ?? this.reviewType,
      type: type ?? this.type,
      itemId: itemId ?? this.itemId,
    );
  }

  Review reset() {
    return Review(
      id: id,
      ef: 2.5,
      interval: 0,
      streak: 0,
      last: null,
      next: null,
      timesIncorrect: 0,
      timesCorrect: 0,
      reviewType: reviewType,
      type: type,
      itemId: itemId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Review && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Review{ef: ${ef.toStringAsPrecision(2)}, interval: ${interval.toString().padRight(3)}, streak: $streak, '
        'last: ${Date.format(last, full: true, time: true)}, '
        'next: ${Date.format(next, full: true, time: true)}, '
        'correct: ${timesCorrect.toString().padRight(3)}, '
        'incorrect: ${timesIncorrect.toString().padRight(3)}, '
        'accuracy: ${accuracy.toStringAsPrecision(2)}}';
  }
}
