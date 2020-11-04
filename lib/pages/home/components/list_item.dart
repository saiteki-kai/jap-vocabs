import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/utils/date.dart';
import 'package:jap_vocab/utils/progress_color.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:redux/redux.dart';
import 'package:substring_highlight/substring_highlight.dart';

class ListItem extends StatelessWidget {
  final Function onTap;
  final Item item;

  const ListItem({this.item, this.onTap});

  String get _date => Date.format(item.nextReview) ?? 'New';

  String get _example {
    if ((item?.examples?.length ?? 0) > 0) {
      return item.examples.first?.text;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    var search = store.state.filterState.search;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StoreConnector(
          distinct: true,
          converter: (Store<AppState> store) => _ViewModel.create(store),
          builder: (context, _ViewModel vm) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (search != null && search.isNotEmpty)
                        ? SubstringHighlight(
                            text: item.text,
                            term: search,
                            textStyle: Theme.of(context).textTheme.headline6,
                            textStyleHighlight:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.orangeAccent,
                                    ),
                          )
                        : Text(
                            item.text,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                    Text(
                      vm.altLayout ? _example : _date,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      if (vm.altLayout)
                        Container(
                          child: Text(
                            _date.replaceFirstMapped('時', (match) => '時\n'),
                            style: TextStyle(height: 1.1),
                          ),
                          padding: EdgeInsets.all(8.0),
                        ),
                      CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 4.0,
                        percent: item.accuracy,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text('${(item.accuracy * 100).toInt()}'),
                        progressColor: colorPercent(item.accuracy),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      onTap: onTap,
    );
  }
}

class _ViewModel {
  final bool altLayout;

  _ViewModel({this.altLayout});

  factory _ViewModel.create(Store<AppState> store) {
    final altLayout = store.state.settingsState.altLayout;

    return _ViewModel(
      altLayout: altLayout,
    );
  }
}
