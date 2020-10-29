import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/components/md2_indicator.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/order.dart';
import 'package:redux/redux.dart';

class FilterSheet extends StatelessWidget {
  FilterSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsets.only(top: 4),
              child: TabBar(
                tabs: [
                  Tab(text: '並べ替え'),
                  Tab(text: 'フィルター'),
                ],
                unselectedLabelColor: Colors.white30,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MD2Indicator(
                  indicatorHeight: 4.0,
                  indicatorColor: Colors.white,
                  horizontalPadding: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColorLight,
                child: TabBarView(
                  children: [
                    SortSection(),
                    FilterSection(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterSection extends StatefulWidget {
  FilterSection({Key key}) : super(key: key);

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  var _partOfSpeech = [];
  var _jlpt = [];
  var _level = [];

  @override
  Widget build(BuildContext context) {
    /*final style = Theme.of(context).textTheme.subtitle1.copyWith(
          // color: Theme.of(context).accentColor,
          fontWeight: FontWeight.bold,
        );*/

    return Container(
      height: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /*Container(
            padding: const EdgeInsets.all(16.0),
            child: Text('フィルター', style: style),
          ),*/
          ChipsChoice.multiple(
            value: _partOfSpeech,
            options: [
              ChipsChoiceOption(value: '動詞', label: '動詞'),
              ChipsChoiceOption(value: '名詞', label: '名詞'),
              ChipsChoiceOption(value: '形容詞', label: '形容詞'),
              ChipsChoiceOption(value: '名形容動詞', label: '名形容動詞'),
            ],
            onChanged: (value) => setState(() => _partOfSpeech = value),
            itemConfig: ChipsChoiceItemConfig(
              showCheckmark: false,
              unselectedBrightness: Brightness.dark,
              selectedBrightness: Brightness.dark,
            ),
            isWrapped: true,
          ),
          ChipsChoice.multiple(
            value: _jlpt,
            options: [
              ChipsChoiceOption(value: 5, label: 'N5'),
              ChipsChoiceOption(value: 4, label: 'N4'),
              ChipsChoiceOption(value: 3, label: 'N3'),
              ChipsChoiceOption(value: 2, label: 'N2'),
              ChipsChoiceOption(value: 1, label: 'N1'),
            ],
            onChanged: (value) => setState(() => _jlpt = value),
            itemConfig: ChipsChoiceItemConfig(
              showCheckmark: false,
              unselectedBrightness: Brightness.dark,
              selectedBrightness: Brightness.dark,
            ),
            isWrapped: true,
          ),
          ChipsChoice.multiple(
            value: _level,
            options: [
              ChipsChoiceOption(value: 'weak', label: 'Weak'),
              ChipsChoiceOption(value: 'medium', label: 'Medium'),
              ChipsChoiceOption(value: 'strong', label: 'Strong'),
            ],
            onChanged: (value) => setState(() => _level = value),
            itemConfig: ChipsChoiceItemConfig(
              showCheckmark: false,
              unselectedBrightness: Brightness.dark,
              selectedBrightness: Brightness.dark,
            ),
            isWrapped: true,
          ),
        ],
      ),
    );
  }
}

class SortSection extends StatelessWidget {
  SortSection({Key key}) : super(key: key);

  final sorts = [
    'Alphabetical',
    'Next Review',
    'Streak',
    'Accuracy',
  ];

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> state) => _ViewModel.create(state),
      builder: (context, _ViewModel vm) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /*Container(
            padding: const EdgeInsets.all(16.0),
            child: Text('並べ替え', style: style),
          ),*/
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: sorts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sorts[index],
                      style: sorts[index] == vm.field
                          ? TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent,
                            )
                          : null),
                  selected: sorts[index] == vm.field,
                  // selectedTileColor: Colors.red,
                  trailing: sorts[index] == vm.field
                      ? Icon(vm.mode == 'ASC' ? Icons.arrow_upward : Icons.arrow_downward, color: Colors.orangeAccent)
                      : null,
                  onTap: () {
                    if (vm.field != sorts[index]) {
                      vm.setField(sorts[index]);
                    } else {
                      vm.setMode(vm.mode == 'ASC' ? 'DESC' : 'ASC');
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ViewModel {
  final String field;
  final String mode;
  final Function(String) setField;
  final Function(String) setMode;

  _ViewModel({this.field, this.mode, this.setField, this.setMode});

  factory _ViewModel.create(Store<AppState> store) {
    final _field = store.state.orderState.field;
    final _mode = store.state.orderState.mode;

    void _setField(String field) {
      store.dispatch(changeSortField(field));
    }

    void _setMode(String mode) {
      store.dispatch(changeSortMode(mode));
    }

    return _ViewModel(
      field: _field,
      mode: _mode,
      setField: _setField,
      setMode: _setMode,
    );
  }
}
