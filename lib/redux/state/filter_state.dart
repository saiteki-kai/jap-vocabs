import 'package:flutter/foundation.dart';

@immutable
class FilterState {
  final String type;
  final String search;
  final bool showFavorite;

  final List<int> jlpt;
  final List<String> level;
  final List<String> partOfSpeech;

  const FilterState({
    @required this.type,
    this.search,
    this.showFavorite,
    this.jlpt,
    this.level,
    this.partOfSpeech,
  });

  FilterState.initial()
      : type = 'word',
        search = null,
        showFavorite = false,
        jlpt = null,
        level = null,
        partOfSpeech = null;

  FilterState copyWith({
    String type,
    String search,
    bool showFavorite,
    List<int> jlpt,
    List<String> level,
    List<String> partOfSpeech,
  }) {
    return FilterState(
      type: type ?? this.type,
      search: search ?? this.search,
      showFavorite: showFavorite ?? this.showFavorite,
      jlpt: jlpt ?? this.jlpt,
      level: level ?? this.level,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterState &&
          type == other.type &&
          search == other.search &&
          showFavorite == other.showFavorite &&
          jlpt == other.jlpt &&
          level == other.level &&
          partOfSpeech == other.partOfSpeech;

  @override
  int get hashCode =>
      type.hashCode ^
      search.hashCode ^
      showFavorite.hashCode ^
      jlpt.hashCode ^
      level.hashCode ^
      partOfSpeech.hashCode;
}
