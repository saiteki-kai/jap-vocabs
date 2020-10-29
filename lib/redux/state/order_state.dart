import 'package:flutter/foundation.dart';

@immutable
class OrderState {
  final String field;
  final String mode;
  const OrderState({this.field, this.mode});

  OrderState.initial()
      : field = 'Next Review',
        mode = 'DESC';

  OrderState copyWith({field, mode}) {
    return OrderState(
      field: field ?? this.field,
      mode: mode ?? this.mode,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderState && field == other.field && mode == other.mode;

  @override
  int get hashCode => field.hashCode ^ mode.hashCode;

  static OrderState fromJson(dynamic json) {
    if (json == null) return null;

    return OrderState(
      field: json['field'] ?? 'Next Review',
      mode: json['mode'] ?? 'DESC',
    );
  }

  dynamic toJson() {
    return {
      'field': field,
      'mode': mode,
    };
  }
}
