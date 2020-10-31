import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/order.dart';
import 'package:redux/redux.dart';

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
                  trailing: sorts[index] == vm.field
                      ? Icon(
                          vm.mode == 'ASC'
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.orangeAccent,
                        )
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
