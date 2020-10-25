import 'package:jap_vocab/models/review.dart';

class LoadingReviewsAction {}

class LoadedReviewsAction {
  final List<Review> reviews;

  LoadedReviewsAction(this.reviews);
}
