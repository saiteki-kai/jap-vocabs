import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/reviews.dart';
import 'package:redux/redux.dart';

class ReviewButton extends StatelessWidget {
  void _onPressed(BuildContext context, List<Review> reviews) {
    Navigator.pushNamed(context, '/reviews', arguments: {'reviews': reviews});
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      onInitialBuild: (_ViewModel vm) => vm.getAllReviews(),
      builder: (BuildContext context, _ViewModel vm) {
        return Badge(
          badgeContent: Text(
            vm.reviewsCount.toString(),
            style: TextStyle(color: Colors.white),
          ),
          toAnimate: false,
          animationType: BadgeAnimationType.scale,
          borderRadius: 8.0,
          badgeColor: Color(0xffff7e65),
          shape: BadgeShape.square,
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          position: BadgePosition.topEnd(end: -10.0, top: -10.0),
          child: FloatingActionButton.extended(
            onPressed: vm.reviewsCount > 0
                ? () => _onPressed(context, vm.reviews)
                : null,
            label: Text(
              S.of(context).reviews,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
            disabledElevation: 4,
            backgroundColor: vm.reviewsCount > 0 ? null : Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List<Review> reviews;
  final int reviewsCount;
  final Function getAllReviews;

  _ViewModel({this.reviews, this.reviewsCount, this.getAllReviews});

  factory _ViewModel.create(Store<AppState> store) {
    final _count = store.state.reviewsState.reviews?.length ?? 0;
    final _reviews = store.state.reviewsState.reviews;

    void _getReviews() {
      store.dispatch(getReviews());
    }

    return _ViewModel(
      reviewsCount: _count,
      reviews: _reviews,
      getAllReviews: _getReviews,
    );
  }
}
