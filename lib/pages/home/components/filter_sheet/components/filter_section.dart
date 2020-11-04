import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/filter.dart';
import 'package:redux/redux.dart';

class FilterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chipConfig = ChipsChoiceItemConfig(
      showCheckmark: false,
      unselectedBrightness: Brightness.dark,
      selectedBrightness: Brightness.dark,
      selectedColor: Theme.of(context).accentColor,
      margin: EdgeInsets.zero,
      spacing: 8.0,
      labelStyle: Theme.of(context).textTheme.caption,
    );

    final _style = Theme.of(context).textTheme.subtitle1;

    // TODO: add select all / deselect all button
    return StoreConnector(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (context, _ViewModel vm) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('JLPT', style: _style),
              ChipsChoice<int>.multiple(
                value: vm.jlpt,
                options: [
                  ChipsChoiceOption(value: 5, label: 'N5'),
                  ChipsChoiceOption(value: 4, label: 'N4'),
                  ChipsChoiceOption(value: 3, label: 'N3'),
                  ChipsChoiceOption(value: 2, label: 'N2'),
                  ChipsChoiceOption(value: 1, label: 'N1'),
                ],
                onChanged: (value) => vm.setJLPT(value),
                itemConfig: _chipConfig,
                padding: EdgeInsets.zero,
                isWrapped: true,
              ),
              Text(S.of(context).item_level, style: _style),
              ChipsChoice<String>.multiple(
                value: vm.level,
                options: [
                  ChipsChoiceOption(value: 'weak', label: 'Weak'),
                  ChipsChoiceOption(value: 'medium', label: 'Medium'),
                  ChipsChoiceOption(value: 'strong', label: 'Strong'),
                ],
                onChanged: (value) => vm.setLevel(value),
                itemConfig: _chipConfig,
                padding: EdgeInsets.zero,
                isWrapped: true,
              ),
              Text(S.of(context).item_partofspeech, style: _style),
              ChipsChoice<String>.multiple(
                value: vm.partOfSpeech,
                options: [
                  ChipsChoiceOption(
                    value: 'avverbio',
                    label: 'avverbio',
                  ),
                  ChipsChoiceOption(
                    value: 'aggettivo-no',
                    label: 'aggettivo-no',
                  ),
                  ChipsChoiceOption(
                    value: 'aggettivo-na',
                    label: 'aggettivo-na',
                  ),
                  ChipsChoiceOption(
                    value: 'verbo',
                    label: 'verbo',
                  ),
                  ChipsChoiceOption(
                    value: 'verbo-transitivo',
                    label: 'verbo transitivo',
                  ),
                  ChipsChoiceOption(
                    value: 'verbo-intransitivo',
                    label: 'verbo intransitivo',
                  ),
                  ChipsChoiceOption(
                    value: 'verbo-suru',
                    label: 'verbo suru',
                  ),
                  ChipsChoiceOption(
                    value: 'sostantivo',
                    label: 'sostantivo',
                  ),
                ],
                onChanged: (value) => vm.setPartOfSpeech(value),
                itemConfig: _chipConfig,
                padding: EdgeInsets.zero,
                isWrapped: true,
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
