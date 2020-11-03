import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/settings.dart';
import 'package:redux/redux.dart';

class LanguageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _languages = {
      'it': S.of(context).it,
      'en': S.of(context).en,
      'ja': S.of(context).ja,
    };

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).settings_language,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffff7e65),
                  ),
            ),
          ),
          StoreConnector(
            converter: (Store<AppState> store) => _ViewModel.create(store),
            builder: (context, _ViewModel vm) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  value: vm.languageCode,
                  isExpanded: true,
                  underline: Container(),
                  items: _languages.keys.map((String key) {
                    return DropdownMenuItem(
                      value: key,
                      child: Text(_languages[key]),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    vm.changeLocale(value);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  final String languageCode;
  final Function(String) changeLocale;

  _ViewModel({this.changeLocale, this.languageCode});

  factory _ViewModel.create(Store<AppState> store) {
    final _languageCode = store.state.settingsState.languageCode;

    void _changeLocale(String value) {
      store.dispatch(setLocaleAction(value));
    }

    return _ViewModel(
      languageCode: _languageCode,
      changeLocale: _changeLocale,
    );
  }
}
