import 'package:jap_vocab/data/review.dart';

class LoadingReviewsAction {}

class LoadedReviewsAction {
  final List<Review> reviews;

  LoadedReviewsAction(this.reviews);
}
