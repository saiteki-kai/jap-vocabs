import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/order.dart';
import 'package:redux/redux.dart';

class SortSection extends StatelessWidget {
  const SortSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sorts = [
      {'key': 'Alphabetical', 'value': S.of(context).alphabetical},
      {'key': 'Next Review', 'value': S.of(context).item_nextreview},
      {'key': 'Streak', 'value': S.of(context).item_streak},
      {'key': 'Accuracy', 'value': S.of(context).accuracy},
    ];

    return StoreConnector(
      distinct: true,
      converter: (Store<AppState> state) => _ViewModel.create(state),
      builder: (context, _ViewModel vm) {
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _sorts.length,
          itemBuilder: (context, index) {
            final enabled = _sorts[index]['key'] == vm.field;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: InkWell(
                onTap: () {
                  if (!enabled) {
                    vm.setField(_sorts[index]['key']);
                  } else {
                    vm.setMode(vm.mode == 'ASC' ? 'DESC' : 'ASC');
                  }
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: enabled ? Colors.indigo[400] : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _sorts[index]['value'],
                        style: TextStyle(
                          fontWeight: enabled ? FontWeight.bold : null,
                          color: Colors.white,
                        ),
                      ),
                      if (enabled)
                        Icon(
                          vm.mode == 'ASC'
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                          size: 20,
                        )
                    ],
                  ),
                ),
              ),
            );
          },
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
