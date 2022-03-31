import 'package:jap_vocab/database/review_dao.dart';
import 'package:jap_vocab/redux/actions/filter_actions.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';
import 'package:jap_vocab/redux/thunk/reviews.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> changeSearch(String search) {
  return (Store<AppState> store) async {
    await store.dispatch(ChangeSearchAction(search));
    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> changeType(String type) {
  return (Store<AppState> store) async {
    await store.dispatch(ChangeTypeAction(type));
    await store.dispatch(getItems());
    await store.dispatch(getReviews(filter: ReviewsFilter.NOW));
  };
}

ThunkAction<AppState> changeJLPT(List<int> jlpt) {
  return (Store<AppState> store) async {
    await store.dispatch(ChangeJLTPAction(jlpt));
    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> changeLevel(List<String> level) {
  return (Store<AppState> store) async {
    await store.dispatch(ChangeLevelAction(level));
    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> changePartOfSpeech(List<String> partOfSpeech) {
  return (Store<AppState> store) async {
    await store.dispatch(ChangePartOfSpeechAction(partOfSpeech));
    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> showFavorite(bool favorite) {
  return (Store<AppState> store) async {
    await store.dispatch(ShowFavoriteAction(favorite));
    await store.dispatch(getItems());
  };
}
