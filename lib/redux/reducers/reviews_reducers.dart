import 'package:jap_vocab/redux/actions/reviews_actions.dart';
import 'package:jap_vocab/redux/state/reviews_state.dart';
import 'package:redux/redux.dart';

Reducer<ReviewsState> reviewsReducer = combineReducers<ReviewsState>([
  TypedReducer<ReviewsState, LoadedReviewsAction>(_loadReviewsReducer),
]);

ReviewsState _loadReviewsReducer(
    ReviewsState state, LoadedReviewsAction action) {
  return state.copyWith(reviews: action.reviews);
}
