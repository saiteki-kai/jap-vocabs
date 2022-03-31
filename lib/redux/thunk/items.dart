import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/models/example.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/database/item_dao.dart';
import 'package:jap_vocab/database/review_dao.dart';
import 'package:jap_vocab/redux/actions/items_actions.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/reviews.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:uuid/uuid.dart';

ThunkAction<AppState> getItems() {
  return (Store<AppState> store) async {
    await store.dispatch(LoadingItemsAction());

    var filter = store.state.filterState;
    var order = store.state.orderState;

    final items = await ItemDao().getAllItems(filter: filter, order: order);
    await store.dispatch(LoadedItemsAction(items));
  };
}

ThunkAction<AppState> getItem(String id) {
  return (Store<AppState> store) async {
    await store.dispatch(LoadingItemAction());

    final item = await ItemDao().getItemById(id);
    item.review1 = await ReviewDao().getReviewById(item.reviewId1);
    item.review2 = await ReviewDao().getReviewById(item.reviewId2);

    await store.dispatch(LoadedItemAction(item));
  };
}

ThunkAction<AppState> addItem(Item item) {
  return (Store<AppState> store) async {
    final uuid = Uuid();

    var itemId = uuid.v1();
    var reviewId1 = uuid.v1();
    var reviewId2 = uuid.v1();

    final now = DateTime.now();

    await store.dispatch(
      addReview(Review(
        id: reviewId1,
        itemId: itemId,
        type: item.type,
        next: now,
        last: now,
        reviewType: 'meaning',
      )),
    );

    // TODO: check if text not contains kanji
    await store.dispatch(
      addReview(Review(
        id: reviewId2,
        itemId: itemId,
        type: item.type,
        next: now,
        last: now,
        reviewType: item.type == 'kanji' ? 'writing' : 'reading',
      )),
    );

    await ItemDao().insertItem(
      item.copyWith(id: itemId, reviewId1: reviewId1, reviewId2: reviewId2),
    );

    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> updateItem(Item item) {
  return (Store<AppState> store) async {
    await ItemDao().updateItem(item);
    await store.dispatch(getItem(item.id));
    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> deleteItem(Item item) {
  return (Store<AppState> store) async {
    await store.dispatch(deleteReview(item.reviewId1));
    await store.dispatch(deleteReview(item.reviewId2));
    await ItemDao().delete(item.id);
    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> resetItem(Item item) {
  return (Store<AppState> store) async {
    await store.dispatch(resetReview(item.review1));
    await store.dispatch(resetReview(item.review2));
    await store.dispatch(getItem(item.id));
    await store.dispatch(getItems());
  };
}

ThunkAction<AppState> toggleFavoriteItem(Item item) {
  return (Store<AppState> store) async {
    await ItemDao().updateItem(item.copyWith(favorite: !item.favorite));
    await store.dispatch(getItem(item.id));
  };
}

ThunkAction<AppState> addExample(String itemId, Example example) {
  return (Store<AppState> store) async {
    final item = await ItemDao().getItemById(itemId);
    final newItem = item.copyWith(examples: item.examples..add(example));
    await ItemDao().updateItem(newItem);
    await store.dispatch(getItem(itemId));
  };
}
