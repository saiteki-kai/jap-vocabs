import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/pages/home/components/type_button.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/filter.dart';
import 'package:redux/redux.dart';

class ReviewTypeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (context, _ViewModel vm) {
        return Row(
          children: [
            TypeButton(
              text: '語彙',
              selected: vm.type == 'word',
              onPressed: () async {
                if (vm.type != 'word') await vm.setType('word');
              },
            ),
            TypeButton(
              text: '漢字',
              selected: vm.type == 'kanji',
              onPressed: () async {
                if (vm.type != 'kanji') await vm.setType('kanji');
              },
            ),
          ],
        );
      },
    );
  }
}

class _ViewModel {
  final String type;
  final Function(String) setType;

  _ViewModel({this.type, this.setType});

  factory _ViewModel.create(Store<AppState> store) {
    final _type = store.state.filterState.type;

    void _setType(String type) {
      store.dispatch(changeType(type));
    }

    return _ViewModel(
      type: _type,
      setType: _setType,
    );
  }
}
