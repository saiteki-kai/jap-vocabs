import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/database/review_dao.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/redux/thunk/reviews.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/utils/background.dart';
import 'package:redux/redux.dart';

// REF: https://dribbble.com/shots/13891523-Investment-Advisor-App
// REF: https://dribbble.com/shots/14195009-Wallet-App
class HomeReviewsPage extends StatefulWidget {
  const HomeReviewsPage();
  @override
  _HomeReviewsPageState createState() => _HomeReviewsPageState();
}

class _HomeReviewsPageState extends State<HomeReviewsPage> {
  var timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(getReviews(filter: ReviewsFilter.NEXT));

      timer = Timer.periodic(
        Duration(seconds: 60),
        (_) {
          print('getReviews: NEXT');
          store.dispatch(getReviews(filter: ReviewsFilter.NEXT));
        },
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var now = false;

    return StoreConnector(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.dateTime != null) {
          final diff = vm.dateTime.difference(DateTime.now());
          now = diff.isNegative;

          final h = diff.inMinutes.abs() ~/ 60;
          final m = diff.inMinutes.abs() % 60;

          return Column(
            children: [
              ReviewsText(
                title: now ? '${vm.reviewsCount}' : 'Next review in',
                subtitle: now ? 'items ready for review' : '${h}h ${m}m',
                titleStyle: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: now ? 48 : null,
                      fontWeight: now ? FontWeight.w400 : null,
                    ),
              ),
              StartButton(
                text: now && vm.reviewsCount > 0
                    ? 'Start'
                    : '${vm.reviewsCount} Items',
                onPressed: now && vm.reviewsCount > 0
                    ? () {
                        Navigator.pushNamed(
                          context,
                          '/reviews',
                          arguments: {'reviews': vm.reviews},
                        );
                      }
                    : null,
              ),
              SizedBox(height: 48.0),
            ],
          );
        }

        return Center(child: Text('No reviews yet. Insert something'));
      },
    );
  }
}

class ReviewsText extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle titleStyle;

  const ReviewsText(
      {Key key, @required this.title, @required this.subtitle, this.titleStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: titleStyle),
            SizedBox(height: 24.0),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const StartButton({Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48.0),
      child: FlatButton(
        onPressed: onPressed,
        disabledColor: Colors.grey.shade400,
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12.0),
        minWidth: double.infinity,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<Review> reviews;
  final int reviewsCount;
  final DateTime dateTime;
  final Function getAllReviews;

  _ViewModel({
    this.reviews,
    this.dateTime,
    this.reviewsCount,
    this.getAllReviews,
  });

  factory _ViewModel.create(Store<AppState> store) {
    final _count = store.state.reviewsState.reviews?.length ?? 0;
    final _reviews = store.state.reviewsState.reviews;
    final _dateTime =
        _reviews != null && _reviews.isNotEmpty ? _reviews.first.next : null;

    void _getReviews() {
      store.dispatch(getReviews(filter: ReviewsFilter.NEXT));
    }

    return _ViewModel(
      reviewsCount: _count,
      reviews: _reviews,
      dateTime: _dateTime,
      getAllReviews: _getReviews,
    );
  }
}
