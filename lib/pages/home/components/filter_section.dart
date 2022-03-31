import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/filter.dart';
import 'package:jap_vocab/utils/styles.dart';
import 'package:redux/redux.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _style = theme.textTheme.subtitle1.copyWith(
      color: Colors.white,
    );

    final _padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 12.0);

    // TODO: hide partOfSpeech when kanji is selected

    return StoreConnector(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (context, _ViewModel vm) {
        return Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('JLPT', style: _style),
              ),
              ChipsChoice<int>.multiple(
                value: vm.jlpt,
                choiceItems: [
                  C2Choice(value: 5, label: 'N5'),
                  C2Choice(value: 4, label: 'N4'),
                  C2Choice(value: 3, label: 'N3'),
                  C2Choice(value: 2, label: 'N2'),
                  C2Choice(value: 1, label: 'N1'),
                ],
                onChanged: (value) => vm.setJLPT(value),
                choiceStyle: Style.chipTheme,
                wrapped: true,
                spacing: 0,
                padding: _padding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(S.of(context).item_level, style: _style),
              ),
              ChipsChoice<String>.multiple(
                value: vm.level,
                choiceItems: [
                  C2Choice(value: 'weak', label: 'weak'),
                  C2Choice(value: 'medium', label: 'medium'),
                  C2Choice(value: 'strong', label: 'strong'),
                ],
                onChanged: (value) => vm.setLevel(value),
                choiceStyle: Style.chipTheme,
                wrapped: true,
                spacing: 0,
                padding: _padding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(S.of(context).item_partofspeech, style: _style),
              ),
              ChipsChoice<String>.multiple(
                value: vm.partOfSpeech,
                choiceItems: [
                  C2Choice(
                    value: 'avverbio',
                    label: 'avverbio',
                  ),
                  C2Choice(
                    value: 'aggettivo-no',
                    label: 'aggettivo-no',
                  ),
                  C2Choice(
                    value: 'aggettivo-na',
                    label: 'aggettivo-na',
                  ),
                  C2Choice(
                    value: 'verbo',
                    label: 'verbo',
                  ),
                  C2Choice(
                    value: 'verbo-transitivo',
                    label: 'verbo transitivo',
                  ),
                  C2Choice(
                    value: 'verbo-intransitivo',
                    label: 'verbo intransitivo',
                  ),
                  C2Choice(
                    value: 'verbo-suru',
                    label: 'verbo suru',
                  ),
                  C2Choice(
                    value: 'sostantivo',
                    label: 'sostantivo',
                  ),
                ],
                onChanged: (value) => vm.setPartOfSpeech(value),
                choiceStyle: Style.chipTheme,
                wrapped: false,
                padding: _padding,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () async {
                    await vm.setPartOfSpeech([]);
                    await vm.setLevel([]);
                    await vm.setJLPT([]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Reset',
                      style:
                          theme.textTheme.button.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List<int> jlpt;
  final List<String> level;
  final List<String> partOfSpeech;

  final Function(List<int>) setJLPT;
  final Function(List<String>) setLevel;
  final Function(List<String>) setPartOfSpeech;

  _ViewModel({
    this.jlpt,
    this.level,
    this.partOfSpeech,
    this.setJLPT,
    this.setLevel,
    this.setPartOfSpeech,
  });

  factory _ViewModel.create(Store<AppState> store) {
    final _jlpt = store.state.filterState.jlpt;
    final _level = store.state.filterState.level;
    final _partOfSpeech = store.state.filterState.partOfSpeech;

    void _setJLPT(List<int> jlpt) {
      store.dispatch(changeJLPT(jlpt));
    }

    void _setLevel(List<String> level) {
      store.dispatch(changeLevel(level));
    }

    void _setPartOfSpeech(List<String> partOfSpeech) {
      store.dispatch(changePartOfSpeech(partOfSpeech));
    }

    return _ViewModel(
      jlpt: _jlpt,
      level: _level,
      partOfSpeech: _partOfSpeech,
      setJLPT: _setJLPT,
      setLevel: _setLevel,
      setPartOfSpeech: _setPartOfSpeech,
    );
  }
}
