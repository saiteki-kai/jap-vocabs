import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ChangeLayoutAction {
  final bool value;
  const ChangeLayoutAction(this.value);
}

class SetBackupPathAction {
  final String path;
  const SetBackupPathAction(this.path);
}

class ChangeTimeAction {
  final Time time;
  const ChangeTimeAction(this.time);
}

class ChangeDayAction {
  final List<Day> days;
  const ChangeDayAction(this.days);
}

class EnableRemainderAction {
  final bool value;
  const EnableRemainderAction(this.value);
}

class SetLocaleAction {
  final String languageCode;
  const SetLocaleAction(this.languageCode);
}
