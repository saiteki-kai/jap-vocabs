import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/database/review_dao.dart';
import 'package:jap_vocab/redux/actions/reviews_actions.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getReviews({ReviewsFilter filter}) {
  return (Store<AppState> store) async {
    await store.dispatch(LoadingReviewsAction());

    final reviews = await ReviewDao().getAllReviews(filter: filter);
    await store.dispatch(LoadedReviewsAction(reviews..shuffle()));
  };
}

ThunkAction<AppState> addReview(Review review) {
  return (Store<AppState> store) async {
    await ReviewDao().insertReview(review);
    await store.dispatch(getReviews());
  };
}

ThunkAction<AppState> updateReview(Review review) {
  return (Store<AppState> store) async {
    await ReviewDao().updateReview(review);
    await store.dispatch(getReviews());
  };
}

ThunkAction<AppState> resetReview(Review review) {
  return (Store<AppState> store) async {
    await ReviewDao().updateReview(review.reset());
    await store.dispatch(getReviews());
  };
}

ThunkAction<AppState> deleteReview(String id) {
  return (Store<AppState> store) async {
    await ReviewDao().delete(id);
    await store.dispatch(getReviews());
  };
}
