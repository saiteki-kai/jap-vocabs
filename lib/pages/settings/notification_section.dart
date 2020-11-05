import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/redux/actions/settings_actions.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/state/settings_state.dart';
import 'package:jap_vocab/utils/notifications.dart';
import 'package:redux/redux.dart';

class NotificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.create(store),
      onDidChange: (_ViewModel vm) async {
        await Notifications.instance.reviewNotification(
          Remainder(time: vm.time, days: vm.days, enabled: vm.enabled),
        );
      },
      builder: (context, _ViewModel vm) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  S.of(context).settings_notifications,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffff7e65),
                      ),
                ),
              ),
              ListTile(
                title: Text(S.of(context).settings_notifications_enable),
                trailing: Switch(
                  value: vm.enabled,
                  onChanged: (value) async => await vm.enableRemainder(value),
                ),
              ),
              ListTile(
                title: Text(S.of(context).settings_notifications_time),
                subtitle: Text(
                  '${vm.time.hour.toString().padLeft(2, '0')}:'
                  '${vm.time.minute.toString().padLeft(2, '0')}',
                ),
                enabled: vm.enabled,
                onTap: () async {
                  final init = TimeOfDay(
                    hour: vm.time.hour,
                    minute: vm.time.minute,
                  );

                  var time = await showTimePicker(
                    context: context,
                    initialTime: init,
                  );

                  if (time != null) {
                    await vm.changeTime(Time(time.hour, time.minute));
                  }
                },
              ),
              ListTile(
                title: Text(S.of(context).settings_notifications_days),
                subtitle: Text('Everyday'),
                enabled: vm.enabled,
                onTap: () {
                  showDialog(
                    context: context,
                    child: DaysDialog(
                      selected: vm.days,
                      onConfirm: (days) {
                        vm.changeDay(days);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class DaysDialog extends StatefulWidget {
  final List<Day> selected;
  final Function(List<Day>) onConfirm;
  const DaysDialog({Key key, this.selected, this.onConfirm}) : super(key: key);
  @override
  _DaysDialogState createState() => _DaysDialogState();
}

class _DaysDialogState extends State<DaysDialog> {
  final days = [
    {'title': 'Monday', 'key': Day.Monday, 'enabled': false},
    {'title': 'Tuesday', 'key': Day.Tuesday, 'enabled': false},
    {'title': 'Wednesday', 'key': Day.Wednesday, 'enabled': false},
    {'title': 'Thursday', 'key': Day.Thursday, 'enabled': false},
    {'title': 'Friday', 'key': Day.Friday, 'enabled': false},
    {'title': 'Saturday', 'key': Day.Saturday, 'enabled': false},
    {'title': 'Sunday', 'key': Day.Sunday, 'enabled': false},
  ];

  @override
  void initState() {
    setState(() {
      days.forEach((d) => d['enabled'] = widget.selected.contains(d['key']));
    });
    super.initState();
  }

  // TODO: tasto seleziona tutto

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: days.map((day) {
          return CheckboxListTile(
            value: day['enabled'],
            onChanged: (value) {
              setState(() => day['enabled'] = !day['enabled']);
            },
            title: Text(day['title']),
          );
        }).toList(growable: false),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).button_cancel),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onConfirm(days
                .where((d) => d['enabled'])
                .map<Day>((d) => d['key'])
                .toList(growable: false));
          },
          child: Text(S.of(context).button_confirm),
        ),
      ],
    );
  }
}

class _ViewModel {
  final Time time;
  final List<Day> days;
  final bool enabled;

  final Function(Time) changeTime;
  final Function(List<Day>) changeDay;
  final Function(bool) enableRemainder;

  _ViewModel(
      {this.time,
      this.days,
      this.changeTime,
      this.changeDay,
      this.enabled,
      this.enableRemainder});

  factory _ViewModel.create(Store<AppState> store) {
    final time = store.state.settingsState.review.time;
    final days = store.state.settingsState.review.days;
    final enabled = store.state.settingsState.review.enabled;

    void _changeTime(Time time) {
      store.dispatch(ChangeTimeAction(time));
    }

    void _changeDay(List<Day> days) {
      store.dispatch(ChangeDayAction(days));
    }

    void _enableRemainder(bool value) {
      store.dispatch(EnableRemainderAction(value));
    }

    return _ViewModel(
      time: time,
      days: days,
      enabled: enabled,
      changeDay: _changeDay,
      changeTime: _changeTime,
      enableRemainder: _enableRemainder,
    );
  }
}
