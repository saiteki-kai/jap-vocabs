import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/settings.dart';
import 'package:redux/redux.dart';

class LayoutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).settings_display,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffff7e65),
                  ),
            ),
          ),
          StoreConnector(
            converter: (Store<AppState> store) => _ViewModel.create(store),
            builder: (context, _ViewModel vm) {
              return ListTile(
                title: Text(S.of(context).settings_altlayout),
                subtitle: Text(S.of(context).settings_altlayout_descr),
                trailing: Switch(
                  value: vm.altLayout,
                  onChanged: (value) => vm.changeLayout(value),
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
  final bool altLayout;
  final Function(bool) changeLayout;

  _ViewModel({this.altLayout, this.changeLayout});

  factory _ViewModel.create(Store<AppState> store) {
    final altLayout = store.state.settingsState.altLayout;

    void _changeLayout(bool value) {
      store.dispatch(changeLayoutAction(value));
    }

    return _ViewModel(
      altLayout: altLayout,
      changeLayout: _changeLayout,
    );
  }
}
