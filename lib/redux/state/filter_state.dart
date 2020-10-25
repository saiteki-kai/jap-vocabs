import 'package:flutter/foundation.dart';

@immutable
class FilterState {
  final String type;
  final String search;
  const FilterState({@required this.type, this.search});

  FilterState.initial()
      : type = 'word',
        search = null;

  FilterState copyWith({type, search}) {
    return FilterState(
      type: type ?? this.type,
      search: search ?? this.search,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterState && type == other.type && search == other.search;

  @override
  int get hashCode => type.hashCode ^ search.hashCode;
}
