import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/answer.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/utils/review_utils.dart';
import 'package:jap_vocab/utils/sm2.dart';
import 'package:jap_vocab/pages/reviews/components/reviews_appbar.dart';
import 'package:jap_vocab/database/item_dao.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/reviews.dart';
import 'package:jap_vocab/utils/styles.dart';
import 'package:redux/redux.dart';

class ReviewPage extends StatefulWidget {
  final List<Review> reviews;
  const ReviewPage({this.reviews});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

// TODO: Refactoring
class _ReviewPageState extends State<ReviewPage> {
  var _show = false;
  var _showHint = false;
  var _index = 0;
  var _quality = -1;

  final _answers = <Answer>[];

  // TODO: fare in modo che passo le reviews aggiornate e con ReviewsFilter.ALL
  // TODO: gestire le answer con lo store??? potrebbe andare...
  Future<void> _onNext(
      BuildContext context, Item item, Review review, int total) async {
    final store = StoreProvider.of<AppState>(context, listen: false);

    final r = SM2.newIteration(review, _quality);
    await store.dispatch(updateReview(r));

    _answers.add(
      Answer(
        review: r,
        correct: _quality > 2,
        item: item,
      ),
    );

    if (_index + 1 < total) {
      setState(() {
        _index++;
        _show = false;
        _quality = -1;
      });
    } else {
      await Navigator.pushReplacementNamed(
        context,
        '/summary',
        arguments: {'answers': _answers},
      );
    }
  }

  bool get _enable => _quality != -1;

  void _showHelp() {
    showDialog(
      context: context,
      child: AlertDialog(
        contentTextStyle:
            Theme.of(context).textTheme.subtitle1.copyWith(height: 1),
        content: Container(
          height: 240,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0) complete blackout'),
              Text('1) incorrect response; the correct one remembered'),
              Text(
                  '2) incorrect response; where the correct one seemed easy to recall'),
              Text('3) correct response recalled with serious difficulty'),
              Text('4) correct response after a hesitation'),
              Text('5) perfect response'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _showHint = false;
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.reviews.length;
    final review = widget.reviews[_index];

    if (review == null) {
      return Material(
        child: Center(child: Text(S.of(context).loading)),
      );
    }

    return CustomLayout(
      appBar: ReviewAppBar(
        current: _index,
        total: total,
        onSummary: () {
          Navigator.pushReplacementNamed(
            context,
            '/summary',
            arguments: {'answers': _answers},
          );
        },
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            alignment: Alignment.topCenter,
            child: FutureBuilder<Item>(
              future: ItemDao().getItemById(review.itemId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                final item = snapshot.data;
                final hex = item.text.codeUnits.first;

                final response = review.reviewType == 'meaning'
                    ? item.meaning
                    : item.reading;

                final examples = item.examples; // ..shuffle()
                final hint = examples.isNotEmpty ? examples.first.text : '';

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 64.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkResponse(
                                    onTap: hint.isEmpty
                                        ? null
                                        : () {
                                            setState(() => _showHint = true);
                                          },
                                    radius: 40,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.lightbulb,
                                              color: hint.isEmpty
                                                  ? Colors.black45
                                                  : null),
                                          SizedBox(width: 4),
                                          Text(
                                            'Hint',
                                            style: Theme.of(context)
                                                .textTheme
                                                .button
                                                .copyWith(
                                                    color: hint.isEmpty
                                                        ? Colors.black45
                                                        : null),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.3),
                                    ),
                                    child: Text(
                                      reviewType(context, review.reviewType)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 32.0),
                                child: Text(
                                  item.text,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              FlatButton(
                                color: Colors.grey.shade200,
                                child: Text(
                                    S.of(context).button_show.toUpperCase()),
                                onPressed: () {
                                  setState(() {
                                    _showHint = false;
                                    _show = !_show;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: _show || _showHint
                            ? review.reviewType == 'writing'
                                ? SingleChildScrollView(
                                    child: SvgPicture.asset(
                                      'assets/kanji/${hex}_frames.svg',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                  )
                                : Text(
                                    _showHint ? hint : response,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(fontSize: 22.0),
                                  )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ChipsChoice<int>.single(
                        value: _quality,
                        wrapped: true,
                        padding: EdgeInsets.zero,
                        choiceStyle: Style.chipTheme,
                        choiceItems: [
                          C2Choice(value: 0, label: '0'),
                          C2Choice(value: 1, label: '1'),
                          C2Choice(value: 2, label: '2'),
                          C2Choice(value: 3, label: '3'),
                          C2Choice(value: 4, label: '4'),
                          C2Choice(value: 5, label: '5'),
                        ],
                        onChanged: _show
                            ? (val) => setState(() => _quality = val)
                            : (_) => null,
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        child: Text(
                          _index == total - 1
                              ? S.of(context).tooltip_summary
                              : S.of(context).button_next,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: _enable
                            ? () => _onNext(context, item, review, total)
                            : null,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              icon: Icon(Icons.help, color: Colors.grey),
              onPressed: () => _showHelp(),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _ViewModel {
  final List<Review> reviews;
  final Function getAllReviews;

  _ViewModel({this.reviews, this.getAllReviews});

  // ignore: unused_element
  factory _ViewModel.create(Store<AppState> store) {
    final _reviews = store.state.reviewsState.reviews;

    void _getReviews() {
      store.dispatch(getReviews());
    }

    return _ViewModel(
      reviews: _reviews,
      getAllReviews: _getReviews,
    );
  }
}
