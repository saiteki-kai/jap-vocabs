import 'package:flutter/foundation.dart';
import 'package:jap_vocab/redux/state/filter_state.dart';
import 'package:jap_vocab/redux/state/items_state.dart';
import 'package:jap_vocab/redux/state/reviews_state.dart';
import 'package:jap_vocab/redux/state/settings_state.dart';

@immutable
class AppState {
  final ItemsState itemsState;
  final ReviewsState reviewsState;
  final FilterState filterState;
  final SettingsState settingsState;

  const AppState({
    @required this.itemsState,
    @required this.reviewsState,
    @required this.filterState,
    @required this.settingsState,
  });

  AppState.initialState({SettingsState settings})
      : itemsState = ItemsState.initial(),
        reviewsState = ReviewsState.initial(),
        filterState = FilterState.initial(),
        settingsState = settings ?? SettingsState.initial();

  static AppState fromJson(dynamic json) {
    return AppState.initialState(
      settings: SettingsState.fromJson(json['settingsState']),
    );
  }

  dynamic toJson() {
    return {
      'settingsState': settingsState.toJson(),
    };
  }

  AppState copyWith({
    ItemsState itemsState,
    ReviewsState reviewsState,
    FilterState filterState,
    SettingsState settingsState,
  }) {
    return AppState(
      itemsState: itemsState ?? this.itemsState,
      reviewsState: reviewsState ?? this.reviewsState,
      filterState: filterState ?? this.filterState,
      settingsState: settingsState ?? this.settingsState,
    );
  }
}
