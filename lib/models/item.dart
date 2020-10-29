import 'package:flutter/material.dart';
import 'package:jap_vocab/models/example.dart';
import 'package:jap_vocab/models/review.dart';

class Item {
  final String id;
  final String text;
  final String type;
  final bool favorite;
  final String meaning;
  final String reading;
  final String partOfSpeech;
  final int numberOfStrokes;
  final int jlpt;
  final List<Example> examples;

  final String reviewId1;
  final String reviewId2;

  Review review1;
  Review review2;

  Item({
    this.id,
    @required this.text,
    @required this.type,
    @required this.meaning,
    this.favorite = false,
    this.reading,
    this.jlpt,
    this.partOfSpeech,
    this.numberOfStrokes,
    this.examples = const <Example>[],
    this.reviewId1,
    this.reviewId2,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'text': text,
      'type': type,
      'meaning': meaning,
      'examples':
          examples == null ? [] : examples.map((e) => e.toMap()).toList(),
      'reviewId1': reviewId1,
      'reviewId2': reviewId2,
    };

    // Don't persist empty fields that are not required

    if (reading != null && reading.isNotEmpty) {
      map['reading'] = reading;
    }

    if (partOfSpeech != null && partOfSpeech.isNotEmpty) {
      map['part_of_speech'] = partOfSpeech;
    }

    if (favorite) {
      map['favorite'] = favorite;
    }

    if (jlpt != null && jlpt > 0) {
      map['jlpt'] = jlpt;
    }

    if (numberOfStrokes != null && numberOfStrokes > 0) {
      map['number_of_strokes'] = numberOfStrokes;
    }

    return map;
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      text: map['text'],
      type: map['type'],
      favorite: map['favorite'],
      reading: map['reading'],
      meaning: map['meaning'],
      examples: map['examples'] == null
          ? []
          : List.from(map['examples']).map((e) => Example.fromMap(e)).toList(),
      reviewId1: map['reviewId1'],
      reviewId2: map['reviewId2'],
      partOfSpeech: map['part_of_speech'],
      jlpt: map['jlpt'],
      numberOfStrokes: map['number_of_strokes'],
    );
  }

  Item copyWith({
    String id,
    String text,
    String meaning,
    String reading,
    String type,
    int jlpt,
    int numberOfStrokes,
    String partOfSpeech,
    bool favorite,
    List<Example> examples,
    String reviewId1,
    String reviewId2,
  }) {
    return Item(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      reading: reading ?? this.reading,
      meaning: meaning ?? this.meaning,
      jlpt: jlpt ?? this.jlpt,
      numberOfStrokes: numberOfStrokes ?? this.numberOfStrokes,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      favorite: favorite ?? this.favorite,
      examples: examples ?? this.examples,
      reviewId1: reviewId1 ?? this.reviewId1,
      reviewId2: reviewId2 ?? this.reviewId2,
    );
  }

  // Compute total accuracy
  double get accuracy {
    if (review1 == null && review2 == null) return 0.0;
    if (review1 != null && review2 != null) {
      return review1.accuracy * review2.accuracy;
    }

    if (review1 != null) {
      return review1.accuracy;
    } else {
      return review2.accuracy;
    }
  }

  // Compute mean streak
  double get streak {
    if (review1 == null && review2 == null) return 0.0;
    if (review1 != null && review2 != null) {
      return review1.streak * review2.streak * 0.5;
    }

    if (review1 != null) {
      return review1.streak.toDouble();
    } else {
      return review2.streak.toDouble();
    }
  }

  DateTime get nextReview {
    if (review1?.next == null && review2?.next == null) return null;

    var r1 = 8640000000000000; // maxMillisecondsSinceEpoch
    var r2 = 8640000000000000; // maxMillisecondsSinceEpoch

    if (review1?.next != null) r1 = review1.next.millisecondsSinceEpoch;
    if (review2?.next != null) r2 = review2.next.millisecondsSinceEpoch;

    if (r1 < r2) return review1.next;
    return review2.next;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ type.hashCode;

  static Comparator<Item> comparator(String field, String mode) {
    final mult = mode == 'ASC' ? -1 : 1;

    switch(field) {
      case 'Alphabetical':
        return (a, b) => a.text.compareTo(b.text) * mult;
      case 'Streak':
        return (a, b) => a.streak.compareTo(b.streak) * mult;
      case 'Accuracy':
        return (a, b) => a.accuracy.compareTo(b.accuracy) * mult;
      case 'Next Review':
      default:
        return (a, b) => a.nextReview.compareTo(b.nextReview) * mult;
    }
  } 
}
