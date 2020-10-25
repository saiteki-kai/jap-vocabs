import 'package:flutter/foundation.dart';
import 'package:jap_vocab/data/review.dart';

@immutable
class ReviewsState {
  final List<Review> reviews;
  const ReviewsState({@required this.reviews});

  ReviewsState.initial() : reviews = List.unmodifiable(<Review>[]);

  ReviewsState copyWith({List<Review> reviews}) {
    return ReviewsState(
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsState &&
          runtimeType == other.runtimeType &&
          reviews == other.reviews;

  @override
  int get hashCode => reviews.hashCode;
}
