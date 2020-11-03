import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@immutable
class Remainder {
  final bool enabled;
  final List<Day> days;
  final Time time;

  const Remainder({this.days, this.time, this.enabled});
  const Remainder.initial()
      : enabled = false,
        days = const [],
        time = const Time();

  Remainder copyWith({days, time, enabled}) {
    return Remainder(
      days: days ?? this.days,
      time: time ?? this.time,
      enabled: enabled ?? this.enabled,
    );
  }

  dynamic toJson() {
    return {
      'time': time.toMap(),
      'days': days.map((d) => d.value - 1).toList(),
      'enabled': enabled,
    };
  }

  static Remainder fromJson(json) {
    if (json == null) return null;
    print(json);
    print(json['days']);

    return Remainder(
      days: json['days'] != null
          ? json['days'].map<Day>((d) => Day.values[d]).toList()
          : [],
      time: json['time'] != null
          ? Time(json['time']['hour'], json['time']['minute'])
          : Time(),
      enabled: json['enabled'] ?? false,
    );
  }
}

@immutable
class SettingsState {
  final bool altLayout;
  final String backupPath;
  final Remainder review;
  final String languageCode;

  const SettingsState({
    this.altLayout,
    this.backupPath,
    this.review,
    this.languageCode,
  });

  const SettingsState.initial()
      : altLayout = false,
        backupPath = '',
        review = const Remainder.initial(),
        languageCode = 'en';

  SettingsState copyWith({altLayout, backupPath, review, languageCode}) {
    return SettingsState(
      altLayout: altLayout ?? this.altLayout,
      backupPath: backupPath ?? this.backupPath,
      review: review ?? this.review,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  static SettingsState fromJson(dynamic json) {
    if (json == null) return null;

    return SettingsState(
      altLayout: json['alt_layout'] ?? false,
      backupPath: json['backup_path'] ?? '',
      review: Remainder.fromJson(json['review']) ?? Remainder.initial(),
      languageCode: json['languageCode'] ?? 'en',
    );
  }

  dynamic toJson() {
    return {
      'alt_layout': altLayout,
      'backup_path': backupPath,
      'review': review.toJson(),
      'languageCode': languageCode,
    };
  }
}
